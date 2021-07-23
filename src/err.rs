extern crate failure;


use std::error;
use std::fmt::Formatter;



#[derive(Fail, Debug)]
pub enum KvStoreError {
    #[fail(display = "key {} doesn't exist.", _0)]
    KeyNotExist(String),
    #[fail(display = "IO error: {}", error)]
    IoError {error: std::io::Error},
    #[fail(display = "An unknown ereror has occured.")]
    UnknownError,
}

