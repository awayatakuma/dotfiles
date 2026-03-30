#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh
fi

if [ -x "$HOME/.local/bin/mise" ]; then
    MISE_BIN="$HOME/.local/bin/mise"
elif [ -x "$HOME/.local/share/mise/bin/mise" ]; then
    MISE_BIN="$HOME/.local/share/mise/bin/mise"
else
    MISE_BIN="mise"
fi

"$MISE_BIN" trust
"$MISE_BIN" install

if [ ! -d "$XDG_DATA_HOME/zeno" ]; then
    git clone https://github.com/yuki-yano/zeno.zsh.git "$XDG_DATA_HOME/zeno"
fi
