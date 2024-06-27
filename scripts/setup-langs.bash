#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# Go
sudo apt update
sudo apt install -y golang-go

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash -s -- -y

# deno
curl -fsSL https://deno.land/install.sh | sh
