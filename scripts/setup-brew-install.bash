#!/usr/bin/env bash
set -eux

BREW_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"

if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install it first."
    exit 1
fi

brew bundle install --file="$BREW_FILE"
