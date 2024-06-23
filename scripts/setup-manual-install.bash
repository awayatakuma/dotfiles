#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# lazygit
if ! type lazygit >/dev/null 2>&1; then
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	sudo mkdir -p /tmp/lazygit
	sudo curl -Lo /tmp/lazygit/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	sudo tar xf /tmp/lazygit/lazygit.tar.gz -C /tmp/lazygit
	sudo install /tmp/lazygit/lazygit /usr/local/bin
	sudo rm -rf /tmp/lazygit
fi

# lazydocker

go install github.com/jesseduffield/lazydocker@latest
sudo mv ${GOPATH}/bin/lazydocker /usr/local/bin

# nvim
if ! type nvim >/dev/null 2>&1; then
	sudo mkdir -p /tmp/nvim
	sudo curl -Lo /tmp/nvim/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf /tmp/nvim/nvim-linux64.tar.gz
	sudo rm -rf /tmp/nvim
	sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
fi

# fzf
if ! type fzf >/dev/null 2>&1; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/.fzf
	~/.local/share/.fzf/install --bin
fi

# zellij
if ! type zellij >/dev/null 2>&1; then
	wget -c https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz -O - | tar xz
	sudo chmod +x zellij
	sudo chown root:root zellij
	sudo mv zellij /usr/local/bin/zellij
fi

# eza
if ! type eza >/dev/null 2>&1; then
	wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
	sudo chmod +x eza
	sudo chown root:root eza
	sudo mv eza /usr/local/bin/eza
fi

# zeno
if ! type zeno >/dev/null 2>&1; then
	git clone https://github.com/yuki-yano/zeno.zsh.git $XDG_DATA_HOME/zeno
fi
