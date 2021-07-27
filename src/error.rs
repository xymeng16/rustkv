/// The possible error type of KvStore.
#[derive(Fail, Debug)]
#[allow(dead_code)]
pub enum KvStoreError {
    /// The given key doesn't exist.
    #[fail(display = "Key not found.")]
    KeyNotExist(String),
    /// IO error, indicated by filesystem.

    #[fail(display = "IO error: {}.", error)]
    IoError {
        /// * `error` std::io::Error
        error: std::io::Error,
    },

    #[fail(display = "Key/Value length cannot be zero.")]
    KeyValueZeroSizeError,

    #[fail(
        display = "KvStoreLog buf not fully written. Excepted {}, got {}.",
        expected, got
    )]
    LogBufNotFullyWritten { expected: u32, got: u32 },

    /// Unknown errors.
    #[fail(display = "An unknown error has occurred.")]
    UnknownError,
}
