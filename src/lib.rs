#![deny(missing_docs)]
//!
//! This crate defines a simple in-memory key-value store.
//!
extern crate failure;
#[macro_use]
extern crate failure_derive;

use std::collections::hash_map::HashMap;
use std::path::PathBuf;
use std::fs::File;
use std::io::prelude::*;

use failure::Error;
use serde::{Serialize, Deserialize};

/// The possible error type of KvStore.
#[derive(Fail, Debug)]
pub enum KvStoreError {
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

/// The struct of the KvStore.
pub struct KvStore {
    map: HashMap<String, String>,
    logfile: File,
}

impl Drop for KvStore {
    fn drop(&mut self) {

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
        })
    }

    /// Open the KvStore at a given path. Return the KvStore, if successful.
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::open(path).unwrap();
    /// ```
    pub fn open(path: impl Into<PathBuf>) -> Result<KvStore> {
        Ok(KvStore {
            map: HashMap::new(),
            logfile: File::open(path.into())?,
        })
    }

    /// Sets the value of the given key
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
        self.map.insert(key, value);
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
    pub fn get(self: &KvStore, key: String) -> Result<Option<String>> {
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
}

impl Default for KvStore {
    fn default() -> Self {
        Self::new().unwrap()
    }
}
