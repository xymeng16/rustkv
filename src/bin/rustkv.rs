//!
//! rustkv set <KEY> <VALUE>
//! rustkv get <KEY>
//! rustkv rm <KEY>
//! rustkv -V
//!
use rustkv::KvStore;
use std::env;
use structopt::StructOpt;
use rustkv::Result;

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
        Command::Set { key, value } => {
            kvs.set(key.clone(), value.clone())?;
            println!("kv pair {}:{} is set.", key, value);
        },
        Command::Get { key } => match kvs.get(key.clone())? {
            Some(value) => {
                println!("kv pair {}:{} is found.", key, value);
            }
            None => {
                println!("The value of the key {} is not found.", key)
            }
        },
        Command::Rm { key } => {
            kvs.remove(key.clone())?;
            println!("the value of the key {} is removed.", key);
        }
    }

    Ok(())
}
