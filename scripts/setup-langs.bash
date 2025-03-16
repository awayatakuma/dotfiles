#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# Go
if command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y golang-go
elif command -v dnf  &> /dev/null; then
    sudo dnf update
    sudo dnf install -y golang
fi

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash -s -- -y

# deno
curl -fsSL https://deno.land/install.sh | sh
