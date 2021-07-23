#![deny(missing_docs)]
//!
//! This crate defines a simple in-memory key-value store.
//!
extern crate failure;
#[macro_use]
extern crate failure_derive;
mod err;

use std::collections::hash_map::HashMap;
use std::path::PathBuf;
use failure::Error;
use crate::err::KvStoreError;

/// The common return type for the rustkv
pub type Result<T> = std::result::Result<T, Error>;

/// The struct of the KvStore.
pub struct KvStore {
    map: HashMap<String, String>,
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
        })
    }

    /// Open the KvStore at a given path. Return the KvStore, if successful.
    /// ```rust
    /// use rustkv::KvStore;
    ///
    /// let mut kvs = KvStore::open(path).unwrap();
    /// ```
    pub fn open(path: impl Into<PathBuf>) -> Result<KvStore> {
        unimplemented!()
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
    /// assert_eq!(kvs.get(String::from("key")), Some(String::from("value")));;
    /// ```
    pub fn get(self: &KvStore, key: String) -> Result<Option<String>> {
        match self.map.get(key.as_str()).map(String::from) {
            Some(value) => Ok(Some(value)),
            None => Err(Error::from(KvStoreError::KeyNotExist(key))),
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
        self.map.remove(key.as_str());
        Ok(())
    }
}

impl Default for KvStore {
    fn default() -> Self {
        Self::new().unwrap()
    }
}
