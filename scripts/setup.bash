#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

mkdir -p ${XDG_CONFIG_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME}

if command -v apt &> /dev/null; then
    sudo /bin/bash "$CUR_DIR/setup-apt-install.bash"
elif command -v brew &> /dev/null; then
    /bin/bash "$CUR_DIR/setup-brew-install.bash"
fi
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-langs.bash"
/bin/bash "$CUR_DIR/setup-manual-install.bash"
