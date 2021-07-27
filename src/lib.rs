#![deny(missing_docs)]
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

use error::KvStoreError;
use logptr::KvStoreLogPtr;

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
pub struct KvStore {
    map: HashMap<String, KvStoreLogPtr>,
    logfile: File,
    write_buf: Vec<KvStoreCommand>,
    is_read: bool,
    is_dirty: bool,
    latest_log_position: u32,
    // runtime_log: simple_logger::SimpleLogger,
}

impl Drop for KvStore {
    fn drop(&mut self) {
        if self.write_buf.is_empty() {
            return;
        }

        for command in &self.write_buf {
            bson::to_document(command)
                .unwrap()
                .to_writer(&mut self.logfile)
                .unwrap();
        }
        self.logfile.flush().unwrap();
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
        Ok(KvStore {
            map: HashMap::new(),
            logfile: File::create("default.bson")?,
            write_buf: Vec::new(),
            is_read: true,
            is_dirty: false,
            latest_log_position: 0,
        })
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
            logfile: OpenOptions::new()
                .read(true)
                .append(true)
                .create(true)
                .open(path)?,
            write_buf: Vec::new(),
            is_read: false,
            is_dirty: false,
            latest_log_position: 0,
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
        self.map.insert(key, value);

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
        self.replay()?;
        self._get(key)
    }

    fn _get(&self, key: String) -> Result<Option<String>> {
        match self.map.get(key.as_str()) {
            Some(value) => Ok(Some(String::from(value))),
            None => Ok(None),
        }
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
        self.replay()?;

        let command = KvStoreCommand::Rm { key: key.clone() };
        self.write_buf.push(command);

        match self.map.remove(key.as_str()) {
            Some(_) => Ok(()),
            None => Err(From::from(KvStoreError::KeyNotExist(key))),
        }
    }

    #[named]
    fn replay(self: &mut KvStore) -> Result<()> {
        /*
        Some rules of reference in Rust:
        1. an object cannot be borrowed as both mutable and immutable
        2. an object cannot be borrowed as mutable for more than once
        hence, here I may try to use Smart Pointers to avoid breaking
        above rules.
         */
        if !self.is_read {
            // dbg!("self.isread not true!");
            if self.logfile.metadata().unwrap().len() != 0 {
                loop {
                    let command: KvStoreCommand = bson::from_document(
                        bson::Document::from_reader(&mut self.logfile).unwrap(),
                    )?;
                    self.write_buf.push(command);
                    if self.logfile.stream_position()? == self.logfile.metadata().unwrap().len() {
                        break;
                    }
                }
                self.is_read = true;

                // make sure the logfile is loaded successfully before
                for command in &self.write_buf {
                    match command {
                        KvStoreCommand::Set { key, value } => {
                            self.map.insert(key.to_owned(), value.to_owned());
                        }
                        KvStoreCommand::Get { key } => {
                            self._get(key.to_owned())?;
                        }
                        KvStoreCommand::Rm { key } => {
                            self.map.remove(key.as_str());
                        }
                    }
                }
                self.write_buf.clear();
            }
        }
        Ok(())
    }
}

impl Default for KvStore {
    fn default() -> Self {
        Self::new().unwrap()
    }
}
