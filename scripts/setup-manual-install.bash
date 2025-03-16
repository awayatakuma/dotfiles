#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# lazygit
if ! type lazygit >/dev/null 2>&1; then
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	if [ "$(uname)" = 'Linux' ]; then 
		sudo curl -Lo /usr/local/bin/lazygit "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | tar -xzf
	elif  [ "$(uname)" = 'Darwin' ]; then
		sudo curl -Lo /usr/local/bin/lazygit "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Darwin_arm64.tar.gz" | tar -xzf
	fi

	sudo chmod +x /usr/local/bin/lazygit
	sudo chown root:root /usr/local/bin/lazygit
fi

# lazydocker
go install github.com/jesseduffield/lazydocker@latest
sudo mv ${GOPATH}/bin/lazydocker /usr/local/bin

# nvim
if ! type nvim >/dev/null 2>&1; then
	sudo mkdir -p /tmp/nvim
	sudo rm -rf /opt/nvim
	if [ "$(uname)" = 'Linux' ]; then 
		sudo curl -Lo /usr/local/bin/nvim https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz |  tar -xzf
	elif  [ "$(uname)" = 'Darwin' ]; then
		sudo curl -Lo /usr/local/bin/nvim https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz |  tar -xzf
	fi

	sudo chmod +x /usr/local/bin/nvim
	sudo chown root:root /usr/local/bin/nvim
fi

# fzf
if ! type fzf >/dev/null 2>&1; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/.fzf
	~/.local/share/.fzf/install --bin
fi

# zellij
if ! type zellij >/dev/null 2>&1; then
	if [ "$(uname)" = 'Linux' ]; then 
		sudo curl -Lo /usr/local/bin/zellij https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz |  tar -xzf
	elif  [ "$(uname)" = 'Darwin' ]; then
		sudo curl -Lo /tmp/nvim/nvim.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-apple-darwin.tar.gz |  tar -xzf
	fi
	sudo chmod +x /usr/local/bin/zellij
	sudo chown root:root /usr/local/bin/zellij
fi

# zeno
if ! type zeno >/dev/null 2>&1; then
	git clone https://github.com/yuki-yano/zeno.zsh.git $XDG_DATA_HOME/zeno
fi
