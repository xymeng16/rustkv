//!
//! rust-kv set <KEY> <VALUE>
//! rust-kv get <KEY>
//! rust-kv rm <KEY>
//! rust-kv -V
//!
use clap::{load_yaml, App};
use std::env;
use std::process::exit;

fn main() {
    let yaml = load_yaml!("cli.yaml");
    let app = App::from(yaml)
        .about(env!("CARGO_PKG_DESCRIPTION"))
        .version(env!("CARGO_PKG_VERSION"))
        .name(env!("CARGO_PKG_NAME"))
        .author(env!("CARGO_PKG_AUTHORS"));

    let matches = app.get_matches();

    match matches.subcommand() {
        Some(("set", _set_matches)) => {
            eprintln!("unimplemented");
            exit(1);
        }
        Some(("get", _get_matches)) => {
            eprintln!("unimplemented");
            exit(1);
        }
        Some(("rm", _rm_matches)) => {
            eprintln!("unimplemented");
            exit(1);
        }
        _ => unreachable!(),
    }
}
