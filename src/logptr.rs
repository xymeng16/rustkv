// #![deny(missing_docs)]
//!
//! This module handles the basic operations for the log pointers.
//!
extern crate crc32fast;

use super::Result;

use crate::error::KvStoreError;
use byteorder::{ByteOrder, LittleEndian};
use chrono::Utc;
use core::mem::size_of;
use crc32fast::Hasher;
use serde::{Deserialize, Serialize};
use std::fs::{File, OpenOptions};
use std::io::{Seek, SeekFrom, Write};
use std::path::PathBuf;

static BUF_SIZE: usize = 4096;

/// The log pointer which stores the corresponding fields of the log record in the log file
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct KvStoreLogPtr {
    pub file_id: u32,
    pub value_size: u32,
    pub value_position: u64,
    pub timestamp: i64,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct KvStoreLog {
    pub crc: u32,
    pub timestamp: i64,
    pub key_size: u32,
    pub value_size: u32,
    pub key: Vec<u8>,
    pub value: Vec<u8>,
}

#[derive(Debug)]
pub struct KvStoreLogFile {
    pub file_id: u32,
    pub file: File,
    pub is_dirty: bool,
    pub count: u32,
    pub write_buf: Vec<u8>,
    pub current_position: u64,
    // last_modified_time: i64,
}

impl KvStoreLog {
    pub fn new(key: Vec<u8>, value: Vec<u8>) -> Result<KvStoreLog> {
        if key.is_empty() || value.is_empty() {
            return Err(From::from(KvStoreError::KeyValueZeroSizeError));
        }
        let ts = Utc::now().timestamp();
        let mut ret = KvStoreLog {
            crc: 0,
            timestamp: ts,
            key_size: key.len() as u32,
            value_size: value.len() as u32,
            key,
            value,
        };
        ret.crc = ret.get_crc();

        Ok(ret)
    }

    pub fn get_crc(&mut self) -> u32 {
        // compute the crc first
        let mut hasher = Hasher::new();
        let mut ts_buf = [0 as u8; size_of::<i64>()];
        let mut size_buf = [0 as u8; size_of::<u32>()];

        LittleEndian::write_i64(&mut ts_buf, self.timestamp);
        hasher.update(&ts_buf);

        LittleEndian::write_u32(&mut size_buf, self.key_size as u32);
        hasher.update(&size_buf);

        LittleEndian::write_u32(&mut size_buf, self.value_size as u32);
        hasher.update(&size_buf);

        hasher.update(&self.key.as_slice());
        hasher.update(&self.value.as_slice());

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
        let len = file.metadata().unwrap().len();
        Ok(KvStoreLogFile {
            file_id: fid,
            file,
            is_dirty: false,
            count: 0,
            write_buf: Vec::with_capacity(BUF_SIZE),
            current_position: len,
        })
    }

    pub fn append(&mut self, key: String, value: String) -> Result<KvStoreLogPtr> {
        let log = KvStoreLog::new(Vec::from(key), Vec::from(value))?;

        let before_size = self.write_buf.len();
        bson::to_document(&log)?.to_writer(&mut self.write_buf)?;
        let size = self.write_buf.len() - before_size;

        let logptr = KvStoreLogPtr {
            file_id: self.file_id,
            value_size: log.value_size,
            value_position: self.current_position,
            timestamp: log.timestamp,
        };

        self.current_position += size as u64;

        let n_got = self.write_buf.len();
        if n_got >= BUF_SIZE {
            // write back
            let n_expected = self.write_back()?;
            if n_expected != n_got {
                return Err(From::from(KvStoreError::LogBufNotFullyWritten {
                    expected: n_expected as u32,
                    got: n_got as u32,
                }));
            }
        }

        Ok(logptr)
    }

    fn write_back(&mut self) -> Result<usize> {
        let mut n = self.write_buf.len();
        // serialize and write back
        // for logdoc in &self.write_buf {
        //     logdoc.to_writer(&mut self.file)?;
        //     n = n + 1;
        // }
        let before_size = self.file.metadata()?.len();
        self.file.write_all(self.write_buf.as_slice());
        if (self.file.metadata()?.len() - before_size) != n as u64 {
            return Err(From::from(KvStoreError::IoError {
                error: String::from("Strange IO Error: written bytes != write_buf.len()"),
            }));
        }
        self.write_buf.clear();
        Ok(n)
    }

    /// This is a wrapper function of the private write_back(),
    /// I believe there should be some differences between them,
    /// but I haven't figure them out right now.
    /// TODO: set a clear boundary between this function and its private version.
    pub fn force_write_back(&mut self) -> Result<()> {
        self.write_back()?;
        Ok(())
    }

    /// Return the KvStoreLog at the given position after checking CRC.
    /// If failed, return the corresponding KvStoreError type
    pub fn read_and_check(&mut self, pos: u64) -> Result<KvStoreLog> {
        // TODO: how to ensure position is legal?
        self.file.seek(SeekFrom::Start(pos));
        let mut ret: KvStoreLog =
            bson::from_document(bson::Document::from_reader(&mut self.file)?)?;
        let crc = ret.crc;
        if crc == ret.get_crc() {
            return Ok(ret);
        }
        return Err(From::from(KvStoreError::CRCMismatch {
            expected: crc,
            got: ret.get_crc(),
        }));
    }
}
