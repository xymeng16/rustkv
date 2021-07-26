/// The possible error type of KvStore.
#[derive(Fail, Debug)]
#[allow(dead_code)]
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
