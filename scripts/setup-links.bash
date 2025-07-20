#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

ln -sfv ${REPO_DIR}/.zshenv $HOME/.zshenv
ln -sfn ${XDG_CONFIG_HOME}/vim $HOME/.vim
rm -rf $HOME/.config && ln -sfn ${REPO_DIR}/.config $HOME/
