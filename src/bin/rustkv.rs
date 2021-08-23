//!
//! rustkv set <KEY> <VALUE>
//! rustkv get <KEY>
//! rustkv rm <KEY>
//! rustkv -V
//!

use rustkv::KvStore;
use rustkv::Result;

use std::env;
use std::process::exit;

use structopt::StructOpt;
use rustkv::logptr::KvStoreLogFile;
// use failure::Error;

#[derive(Debug, StructOpt)]
#[structopt(
name = env!("CARGO_PKG_NAME"),
about = env!("CARGO_PKG_DESCRIPTION"),
author = env!("CARGO_PKG_AUTHORS")
)]
struct Opt {
    #[structopt(subcommand)]
    cmd: Command,
}

#[derive(Debug, StructOpt)]
enum Command {
    Set { key: String, value: String },
    Get { key: String },
    Rm { key: String },
}

fn main() -> Result<()> {
    // let mut kvs = KvStore::open(std::env::current_dir().unwrap()).unwrap();
    let mut kvs = KvStore::new()?;
    match Opt::from_args().cmd {
        Command::Set { key, value } => match kvs.set(key, value) {
            Ok(_) => Ok(()),
            Err(e) => {
                println!("{}", e);
                exit(1);
            }
        },
        Command::Get { key } => match kvs.get(key) {
            Ok(value) => {
                match value {
                    Some(value) => println!("{}", value),
                    None => println!("Key not found"),
                }
                Ok(())
            }
            Err(e) => {
                println!("{}", e);
                exit(0);
            }
        },
        Command::Rm { key } => match kvs.remove(key) {
            Ok(_) => Ok(()),
            Err(e) => {
                println!("{}", e);
                exit(1);
            }
        },
    }
}
