#![deny(missing_docs)]
//!
//! This crate defines a simple in-memory key-value store.
//!

use std::collections::hash_map::HashMap;
///
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
    pub fn new() -> KvStore {
        KvStore {
            map: HashMap::new(),
        }
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
    pub fn set(self: &mut KvStore, key: String, value: String) {
        self.map.insert(key, value);
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
    pub fn get(self: &KvStore, key: String) -> Option<String> {
        self.map.get(key.as_str()).map(String::from) // Option::map(f: F)
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
    pub fn remove(self: &mut KvStore, key: String) {
        self.map.remove(key.as_str());
    }
}

impl Default for KvStore {
    fn default() -> Self {
        Self::new()
    }
}
