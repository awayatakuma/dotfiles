#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# Go
export GOPATH="$XDG_DATA_HOME/go"
sudo apt update
sudo apt install -y golang-go

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash -s -- -y

# deno
export DENO_HOME="$XDG_DATA_HOME/deno"
curl -fsSL https://deno.land/install.sh | sh
