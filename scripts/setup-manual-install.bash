#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

cleanup() {
    sudo rm -rf /tmp/workdir
}

get_latest_version() {
    curl -s "$1" | grep '"tag_name"' | awk -F'"' '{print $4}' | sed 's/^v//' | head -1
}

trap cleanup EXIT

# lazygit
if ! type lazygit >/dev/null 2>&1; then
    LAZYGIT_VERSION=$(get_latest_version "https://api.github.com/repos/jesseduffield/lazygit/releases/latest")
    sudo mkdir -p /tmp/workdir
    if [ "$(uname)" = 'Linux' ]; then
        sudo curl -Lo /tmp/workdir/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    elif [ "$(uname)" = 'Darwin' ]; then
        sudo curl -Lo /tmp/workdir/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Darwin_arm64.tar.gz"
    fi
    sudo tar -xzf /tmp/workdir/lazygit.tar.gz -C /tmp/workdir
    sudo mv /tmp/workdir/lazygit /usr/local/bin/
    sudo chmod +x /usr/local/bin/lazygit
    if [ "$(uname)" = 'Linux' ]; then
        sudo chown root:root /usr/local/bin/lazygit
    fi
fi

# lazydocker
if ! type lazydocker >/dev/null 2>&1; then
    go install github.com/jesseduffield/lazydocker@latest
    sudo mv ${GOPATH}/bin/lazydocker /usr/local/bin
fi

# nvim
if ! type nvim >/dev/null 2>&1; then
    sudo mkdir -p /tmp/workdir
    NEO_VIM_VERSION=$(get_latest_version "https://api.github.com/repos/neovim/neovim/releases/latest")
    if [ "$(uname)" = 'Linux' ]; then
        sudo curl -Lo /tmp/workdir/nvim.tar.gz "https://github.com/neovim/neovim/releases/download/v${NEO_VIM_VERSION}/nvim-linux-x86_64.tar.gz"

    elif [ "$(uname)" = 'Darwin' ]; then
        sudo curl -Lo /tmp/workdir/nvim.tar.gz "https://github.com/neovim/neovim/releases/download/v${NEO_VIM_VERSION}/nvim-macos-arm64.tar.gz"
    fi
    sudo tar -xzf /tmp/workdir/nvim.tar.gz -C /tmp/workdir
    sudo mv /tmp/workdir/nvim-*/bin/nvim /usr/local/bin/
    sudo chmod +x /usr/local/bin/nvim
    if [ "$(uname)" = 'Linux' ]; then
        sudo chown root:root /usr/local/bin/nvim
    fi
fi

# fzf
if ! type fzf >/dev/null 2>&1; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/.fzf
    ~/.local/share/.fzf/install --bin
fi

# zellij
if ! type zellij >/dev/null 2>&1; then
    sudo mkdir -p /tmp/workdir
    if [ "$(uname)" = 'Linux' ]; then
        sudo curl -Lo /tmp/workdir/zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
    elif [ "$(uname)" = 'Darwin' ]; then
        sudo curl -Lo /tmp/workdir/zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-apple-darwin.tar.gz"
    fi
    sudo tar -xzf /tmp/workdir/zellij.tar.gz -C /tmp/workdir
    sudo mv /tmp/workdir/zellij /usr/local/bin/
    sudo chmod +x /usr/local/bin/zellij
    if [ "$(uname)" = 'Linux' ]; then
        sudo chown root:root /usr/local/bin/zellij
    fi
fi

# zeno
if ! type zeno >/dev/null 2>&1; then
    git clone https://github.com/yuki-yano/zeno.zsh.git $XDG_DATA_HOME/zeno
fi

# eza
# ubuntu and mac are expected to install it via package managers
# this code is virtually for almalinux
if ! command -v eza >/dev/null 2>&1; then
    sudo mkdir -p /tmp/workdir
    EZA_VERSION=$(get_latest_version "https://api.github.com/repos/eza-community/eza/releases/latest")
    if [ "$(uname)" = 'Linux' ]; then
        sudo curl -Lo /tmp/workdir/eza.tar.gz "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-musl.tar.gz"
    fi
    sudo tar -xzf /tmp/workdir/eza.tar.gz -C /tmp/workdir
    sudo mv /tmp/workdir/eza /usr/local/bin/eza
    sudo chmod +x /usr/local/bin/eza
    if [ "$(uname)" = 'Linux' ]; then
        sudo chown root:root /usr/local/bin/eza
    fi
fi