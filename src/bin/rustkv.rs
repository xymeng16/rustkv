//!
//! rustkv set <KEY> <VALUE>
//! rustkv get <KEY>
//! rustkv rm <KEY>
//! rustkv -V
//!
use failure::Error;
use rustkv::KvStore;
use rustkv::Result;
use std::env;
use std::process::exit;
use structopt::StructOpt;

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
    let mut kvs = KvStore::new().unwrap();

    match Opt::from_args().cmd {
        Command::Set { key, value } => match kvs.set(key.clone(), value.clone()) {
            Ok(_) => Ok(()),
            Err(e) => {
                println!("{}", e);
                exit(1);
            }
        },
        Command::Get { key } => match kvs.get(key.clone()) {
            Ok(value) => {
                println!("{}", value.unwrap());
                Ok(())
            }
            Err(e) => {
                println!("{}", e);
                exit(0);
            }
        },
        Command::Rm { key } => match kvs.remove(key.clone()) {
            Ok(_) => Ok(()),
            Err(e) => {
                println!("{}", e);
                exit(1);
            }
        },
    }
}
