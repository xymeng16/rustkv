#![deny(missing_docs)]
//!
//! This crate defines a simple in-memory key-value store.
//!
extern crate failure;
#[macro_use]
extern crate failure_derive;

use std::collections::hash_map::HashMap;
use std::fs::{File, OpenOptions};
use std::io::prelude::*;
use std::path::PathBuf;

use failure::Error;
use serde::{Deserialize, Serialize};
use std::io::SeekFrom;

/// The possible error type of KvStore.
#[derive(Fail, Debug)]
enum KvStoreError {
    /// The given key doesn't exist.
    #[fail(display = "Key not found")]
    KeyNotExist(String),
    /// IO error, indicated by filesystem.

    #[fail(display = "IO error: {}", error)]
    IoError {
        /// * `error` std::io::Error
        error: std::io::Error,
    },
    /// Unknown errors.
    #[fail(display = "An unknown error has occurred.")]
    UnknownError,
}

/// The common return type for the rustkv
pub type Result<T> = std::result::Result<T, Error>;

#[derive(Serialize, Deserialize, Debug)]
enum KvStoreCommand {
    SET { key: String, value: String },
    GET { key: String },
    RM { key: String },
}

#[derive(Serialize, Deserialize, Debug)]
struct KVStoreBuffer {
    buf: Vec<KvStoreCommand>,
    count: usize, // TODO: remove useless
}

/// The struct of the KvStore.
pub struct KvStore {
    map: HashMap<String, String>,
    logfile: File,
    write_buf: KVStoreBuffer,
    isread: bool,
    isdirty: bool,
}

impl Drop for KvStore {
    fn drop(&mut self) {
        // write the contents in write_buf into logfile
        bson::to_document(&self.write_buf)
            .unwrap()
            .to_writer(&mut self.logfile);
        self.logfile.flush();
        println!("KVStore dropped and log written to file.");
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
            // logfile: OpenOptions::new().read(true).append(true).create(true).open("default.bson")?,
            logfile: File::open("default.bson")?,
            write_buf: KVStoreBuffer {
                buf: Vec::new(),
                count: 0,
            },
            isread: true,
            isdirty: false,
        })
    }

    /// Open the KvStore at a given path. Return the KvStore, if successful.
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::open(path).unwrap();
    /// ```
    pub fn open(path: impl Into<PathBuf>) -> Result<KvStore> {
        let mut path = path.into();
        path.push("temp");
        path.set_extension("bson");
        println!("{:?}", path);
        Ok(KvStore {
            map: HashMap::new(),
            logfile: OpenOptions::new().read(true).append(true).create(true).open(path)?,
            write_buf: KVStoreBuffer {
                buf: Vec::new(),
                count: 0,
            },
            isread: false,
            isdirty: false,
        })
    }

    /// Sets the value of the given key in a write-ahead manner
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let key = String::from("key");
    /// let value = String::from("value");
    ///
    /// let mut kvs = KvStore::new();
    ///
    /// kvs.set(key, value);
    /// ```
    pub fn set(self: &mut KvStore, key: String, value: String) -> Result<()> {
        // convert the set function call into a command string
        let command = KvStoreCommand::SET {
            key: key.clone(),
            value: value.clone(),
        };
        self.write_buf.buf.push(command);

        // TODO: consider when to perform the real writing operation
        self.map.insert(key, value);

        self.isdirty = true;

        Ok(())
    }

    /// Returns the value corresponding to the key, wrapped in Option\<String\>.
    /// If the key doesn't exist, return None
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::new();
    ///
    /// kvs.set(String::from("key"), String::from("value"));
    ///
    /// assert_eq!(kvs.get(String::from("key")), Some(String::from("value")));
    /// ```
    pub fn get(mut self, key: String) -> Result<Option<String>> {
        // read from the log file before getting from the hashmap, if necessary
        if !self.isread {
            self.write_buf = bson::from_document(bson::Document::from_reader(&mut self.logfile).unwrap())?;
            self.isread = true;

        }

        match self.map.get(key.as_str()) {
            Some(value) => Ok(Some(String::from(value))),
            None => Err(From::from(KvStoreError::KeyNotExist(key))),
        }
    }

    /// Removes a key from the KvStore if existed
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::new();
    ///
    /// kvs.set(String::from("key"), String::from("value"));
    ///
    /// assert_eq!(kvs.get(String::from("key")), Some(String::from("value")));
    ///
    /// kvs.remove(String::from("key"));
    ///
    /// assert_eq!(kvs.get(String::from("key")), None);
    /// ```
    pub fn remove(self: &mut KvStore, key: String) -> Result<()> {
        match self.map.remove(key.as_str()) {
            Some(key) => Ok(()),
            None => Err(From::from(KvStoreError::KeyNotExist(key))),
        }
    }

    fn replay(self: &mut KvStore) -> Result<()> {
        let buf = &mut self.write_buf.buf;
        // make sure the logfile is loaded successfully
        for command in buf.as_slice() {
            match command {
                KvStoreCommand::SET {key, value} => {
                    self.set(*key, *value)?;
                },
                KvStoreCommand::GET {key} => {
                    self.get(*key)?;
                },
                KvStoreCommand::RM {key} => {
                    self.remove(*key)?;
                }
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
