//!
//! rustkv set <KEY> <VALUE>
//! rustkv get <KEY>
//! rustkv rm <KEY>
//! rustkv -V
//!
use clap::{load_yaml, App};
use std::env;
use std::process::exit;
use structopt::StructOpt;
use rustkv::KvStore;

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

fn main() {
    // let opt = Opt::from_args();
    // println!("{:?}", opt.cmd);
    // let yaml = load_yaml!("cli.yaml");
    // let app = App::from(yaml)
    //     .about(env!("CARGO_PKG_DESCRIPTION"))
    //     .version(env!("CARGO_PKG_VERSION"))
    //     .name(env!("CARGO_PKG_NAME"))
    //     .author(env!("CARGO_PKG_AUTHORS"));
    //
    // let matches = app.get_matches();
    //
    // match matches.subcommand() {
    //     Some(("set", _set_matches)) => {
    //         eprintln!("unimplemented");
    //         exit(1);
    //     }
    //     Some(("get", _get_matches)) => {
    //         eprintln!("unimplemented");
    //         exit(1);
    //     }
    //     Some(("rm", _rm_matches)) => {
    //         eprintln!("unimplemented");
    //         exit(1);
    //     }
    //     _ => unreachable!(),
    // }
    let mut kvs = KvStore::new();
    match Opt::from_args().cmd {
        Command::Set{key, value} => {
            kvs.set(key.clone(), value.clone());
            println!("kv pair {}:{} is set.", key, value)
        },
        Command::Get{key} => {
            match kvs.get(key.clone()) {
                Some(value) => {
                    println!("kv pair {}:{} is found.", key, value)
                },
                None => {
                    println!("The value of the key {} is not found.", key)
                },
            }
        },
        Command::Rm {key} => {
            kvs.remove(key.clone());
            println!("the value of the key {} is removed.", key)
        }
    }
}
