#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

mkdir -p ${XDG_CONFIG_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME}

sudo /bin/bash "$CUR_DIR/setup-apt-install.bash"
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-langs.bash"
/bin/bash "$CUR_DIR/setup-manual-install.bash"
