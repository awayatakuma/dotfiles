#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

mkdir -p ${XDG_CONFIG_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME}

if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v apt &> /dev/null; then
    sudo /bin/bash "$CUR_DIR/setup-apt-install.bash"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    /bin/bash "$CUR_DIR/setup-brew-install.bash"
else
    echo "Unsupported OS: $OSTYPE (apt required for Linux)"
    exit 1
fi
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-langs.bash"
/bin/bash "$CUR_DIR/setup-manual-install.bash"
