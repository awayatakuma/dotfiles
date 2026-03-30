#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

BREW_FILE="${REPO_DIR}/.config/homebrew/Brewfile"

if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install it first."
    exit 1
fi

tap "yuru7/tap"
brew bundle install --file="$BREW_FILE"
