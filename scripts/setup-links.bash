#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

mkdir -p "$XDG_CONFIG_HOME"

ln -sfv "${REPO_DIR}/.zshenv" "$HOME/.zshenv"
ln -sfn "${XDG_CONFIG_HOME}/vim" "$HOME/.vim"
ln -sfnv "${REPO_DIR}/.config/"* "$XDG_CONFIG_HOME"
