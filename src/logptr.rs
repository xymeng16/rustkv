#![feature(int_bits_const)]

extern crate crc32fast;

use super::Result;

use crate::error::KvStoreError;
use byteorder::{ByteOrder, LittleEndian};
use chrono::Utc;
use core::mem::size_of;
use crc32fast::Hasher;
use serde::{Deserialize, Serialize};
use std::fs::{File, OpenOptions};
use std::mem::size_of_val;
use std::path::PathBuf;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct KvStoreLogPtr {
    file_id: u32,
    value_size: u32,
    value_position: u32,
    timestamp: i64,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
struct KvStoreLog {
    crc: u32,
    timestamp: i64,
    key_size: u32,
    value_size: u32,
    key: Vec<u8>,
    value: Vec<u8>,
}

#[derive(Debug)]
pub struct KvStoreLogFile {
    file_id: u32,
    file: File,
    is_dirty: bool,
    count: u32,
    write_buf: Vec<bson::Document>,
    current_position: u32,
    // last_modified_time: i64,
}

impl KvStoreLog {
    pub fn new(key: Vec<u8>, value: Vec<u8>) -> Result<KvStoreLog> {
        if key.is_empty() || value.is_empty() {
            return Err(From::from(KvStoreError::KeyValueZeroSizeError));
        }
        let ts = Utc::now().timestamp();
        let crc = KvStoreLog::get_crc(&key, &value, ts);

        Ok(KvStoreLog {
            crc,
            timestamp: ts,
            key_size: key.len() as u32,
            value_size: value.len() as u32,
            key,
            value,
        })
    }

    fn get_crc(key: &Vec<u8>, value: &Vec<u8>, timestamp: i64) -> u32 {
        // compute the crc first
        let mut hasher = Hasher::new();
        let mut ts_buf = [0 as u8; size_of::<i64>()];
        let mut size_buf = [0 as u8; size_of::<u32>()];

        LittleEndian::write_i64(&mut ts_buf, timestamp);
        hasher.update(&ts_buf);

        LittleEndian::write_u32(&mut size_buf, key.len() as u32);
        hasher.update(&size_buf);

        LittleEndian::write_u32(&mut size_buf, value.len() as u32);
        hasher.update(&size_buf);

        hasher.update(&key.as_slice());
        hasher.update(&value.as_slice());

        hasher.finalize()
    }
}

impl KvStoreLogFile {
    /// Return an instance of KvStoreLogFile with given path,
    /// open if the file exists, or create a new file.
    pub fn create_or_open(fid: u32, path: impl Into<PathBuf>) -> Result<Self> {
        let file = OpenOptions::new()
            .append(true)
            .create(true)
            .open(path.into())?;
        Ok(KvStoreLogFile {
            file_id: fid,
            file,
            is_dirty: false,
            count: 0,
            write_buf: Vec::with_capacity(16),
            current_position: file.metadata().unwrap().len() as u32,
        })
    }

    pub fn append(&mut self, key: String, value: String) -> Result<KvStoreLogPtr> {
        let log = KvStoreLog::new(Vec::from(key), Vec::from(value))?;
        let doc = bson::to_document(&log)?;

        self.write_buf.push(doc);

        let logptr = KvStoreLogPtr {
            file_id: self.file_id,
            value_size: log.value_size,
            value_position: self.current_position,
            timestamp: log.timestamp,
        };

        self.current_position += doc.len();
        let n_got = self.write_buf.len() as u32;

        if n_got >= 16 {
            // write back
            let n_expected = self.write_back()?;
            if n_expected != n_got {
                return Err(From::from(KvStoreError::LogBufNotFullyWritten {
                    expected: n_expected,
                    got: n_got,
                }));
            }
        }

        Ok(logptr)
    }

    fn write_back(&mut self) -> Result<u32> {
        let mut n = 0u32;
        // serialize and write back
        for logdoc in &self.write_buf {
            logdoc.to_writer(&mut self.file)?;
            n = n + 1;
        }

        Ok(n)
    }

    /// Return the KvStoreLog at the given position after checking CRC.
    /// If failed, return the corresponding KvStoreError type
    pub fn read_and_check(&self, pos: u32) -> Result<KvStoreLog> {
        // TODO: how to ensure position is legal?
    }
}
