// #![deny(missing_docs)]
//!
//! This crate defines a simple in-memory key-value store.
//!
mod error;
pub mod logptr;

extern crate failure;
#[macro_use]
extern crate failure_derive;

use std::collections::hash_map::HashMap;
use std::fs::{File, OpenOptions};
use std::io::prelude::*;
use std::path::PathBuf;

use failure::Error;
use serde::{Deserialize, Serialize};
// use simple_logger::SimpleLogger;
// use log::LevelFilter;
use chrono::Utc;
use function_name::named;

use crate::logptr::KvStoreLogFile;
use error::KvStoreError;
use logptr::KvStoreLogPtr;
use std::borrow::BorrowMut;
use std::env;

static DB_DIR_PATH: &str = "db/";
static INDEX_FILENAME: &str = "index.bson";
// static LOGLEVEL: LevelFilter = LevelFilter::Debug;

// #[derive(Debug)]
// enum KvStoreDebugInfo {
//     LOG_FILE_WRITTEN,
//     KEY_REMOVED,
// }

/// The common return type for the rustkv
pub type Result<T> = std::result::Result<T, Error>;

#[derive(Serialize, Deserialize, Debug, Clone)]
enum KvStoreCommand {
    Set { key: String, value: String },
    Get { key: String },
    Rm { key: String },
}

/// The struct of the KvStore.
/// Inspired by the bitcask structure, we do not save the key-value map
/// directly in the memory. Instead, we save the following tuple for each
/// record (the so-called log pointer):
/// `[file_id, value_size, value_position, timestamp]`
pub struct KvStore{
    map: HashMap<String, KvStoreLogPtr>,
    logfiles: Vec<KvStoreLogFile>,
    active_log_file: usize,
    write_buf: Vec<KvStoreCommand>,
    is_read: bool,
    is_dirty: bool,
    latest_log_position: u32,
    // runtime_log: simple_logger::SimpleLogger,
}

impl Drop for KvStore {
    fn drop(&mut self) {
        if self.logfiles.len() == 0 {
            return;
        }
        self.logfiles[self.active_log_file].force_write_back();
        self.logfiles[self.active_log_file].file.flush();
        let mut index_file = OpenOptions::new().create(true).append(true).open(INDEX_FILENAME).unwrap();
        let mut buf = Vec::new();
        bson::to_document(&self.map)
            .unwrap()
            .to_writer(&mut buf)
            .unwrap();
        let n = buf.len();
        index_file.write_all(buf.as_slice());
        index_file.flush();
    }
}

impl KvStore {
    /// Create a new KvStore instance
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::new();
    /// ```
    pub fn new() -> Result<KvStore> {
        // This should be an initialization routine.
        // Create index file
        {
            let _index_file = File::create(INDEX_FILENAME)?;
            // after leaving this scope, the _index_file is destroyed and created
        }
        let mut ret = KvStore {
            map: HashMap::new(),
            logfiles: Vec::new(),
            active_log_file: 0,
            write_buf: Vec::new(),
            is_read: true,
            is_dirty: false,
            latest_log_position: 0,
        };

        let alf = KvStoreLogFile::create_or_open(0, DB_DIR_PATH.to_owned() + "log1.bson")?;
        ret.logfiles.push(alf);
        std::io::stdout().flush();

        Ok(ret)
    }

    /// Open the KvStore at a given path. Return the KvStore, if successful.
    /// ```rust
    /// use rustkv::KvStore;
    /// use std::path::Path;
    ///
    /// let path = Path::new("./");
    ///
    /// let mut kvs = KvStore::open(path).unwrap();
    /// ```
    pub fn open(path: impl Into<PathBuf>) -> Result<KvStore> {
        let mut path = path.into();
        path.push("log");
        path.set_extension("bson");

        Ok(KvStore {
            map: HashMap::new(),
            logfiles: Vec::new(),
            write_buf: Vec::new(),
            is_read: false,
            is_dirty: false,
            latest_log_position: 0,
            active_log_file: 0, // TODO: fix this
        })
    }

    /// Sets the value of the given key in a write-ahead manner
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let key = String::from("key");
    /// let value = String::from("value");
    ///
    /// let mut kvs = KvStore::new().unwrap();
    ///
    /// kvs.set(key, value);
    /// ```
    pub fn set(&mut self, key: String, value: String) -> Result<()> {
        let command = KvStoreCommand::Set {
            key: key.clone(),
            value: value.clone(),
        };
        self.write_buf.push(command);

        // TODO: consider when to perform the real writing operation
        let logptr = self.logfiles[self.active_log_file].append(key.clone(), value)?;

        self.map.insert(key, logptr);

        self.is_dirty = true;

        Ok(())
    }

    /// Returns the value corresponding to the key, wrapped in Option\<String\>.
    /// If the key doesn't exist, return None
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::new().unwrap();
    ///
    /// kvs.set(String::from("key"), String::from("value"));
    ///
    /// assert_eq!(kvs.get(String::from("key")).unwrap(), Some(String::from("value")));
    /// ```
    pub fn get(&mut self, key: String) -> Result<Option<String>> {
        // self.replay()?;
        self._get(key)
    }

    fn _get(&mut self, key: String) -> Result<Option<String>> {
        // match self.map.get(key.as_str()) {
        //     Some(value) => Ok(Some(value)),
        //     None => Ok(None),
        // }
        let alf = self.logfiles[self.active_log_file].borrow_mut();
        Ok(self.map.get(key.as_str()).map(|logptr| {
            String::from_utf8(alf.read_and_check(logptr.value_position).unwrap().value).unwrap()
        }))
    }

    /// Removes a key from the KvStore if existed
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::new().unwrap();
    ///
    /// kvs.set(String::from("key"), String::from("value"));
    ///
    /// assert_eq!(kvs.get(String::from("key")).unwrap(), Some(String::from("value")));
    ///
    /// kvs.remove(String::from("key"));
    ///
    /// assert_eq!(kvs.get(String::from("key")).unwrap(), None);
    /// ```
    pub fn remove(&mut self, key: String) -> Result<()> {
        // self.replay()?;

        let command = KvStoreCommand::Rm { key: key.clone() };
        self.write_buf.push(command);

        match self.map.remove(key.as_str()) {
            Some(_) => Ok(()),
            None => Err(From::from(KvStoreError::KeyNotExist(key))),
        }
    }

    // #[named]
    // fn replay(self: &mut KvStore<'a>) -> Result<()> {
    //     /*
    //     Some rules of reference in Rust:
    //     1. an object cannot be borrowed as both mutable and immutable
    //     2. an object cannot be borrowed as mutable for more than once
    //     hence, here I may try to use Smart Pointers to avoid breaking
    //     above rules.
    //      */
    //     if !self.is_read {
    //         // dbg!("self.isread not true!");
    //         if self.logfile.metadata().unwrap().len() != 0 {
    //             loop {
    //                 let command: KvStoreCommand = bson::from_document(
    //                     bson::Document::from_reader(&mut self.logfile).unwrap(),
    //                 )?;
    //                 self.write_buf.push(command);
    //                 if self.logfile.stream_position()? == self.logfile.metadata().unwrap().len() {
    //                     break;
    //                 }
    //             }
    //             self.is_read = true;
    //
    //             // make sure the logfile is loaded successfully before
    //             for command in &self.write_buf {
    //                 match command {
    //                     KvStoreCommand::Set { key, value } => {
    //                         self.map.insert(key.to_owned(), value.to_owned());
    //                     }
    //                     KvStoreCommand::Get { key } => {
    //                         self._get(key.to_owned())?;
    //                     }
    //                     KvStoreCommand::Rm { key } => {
    //                         self.map.remove(key.as_str());
    //                     }
    //                 }
    //             }
    //             self.write_buf.clear();
    //         }
    //     }
    //     Ok(())
    // }
}

impl Default for KvStore {
    fn default() -> Self {
        Self::new().unwrap()
    }
}
