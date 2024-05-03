#!/usr/bin/env bash
set -eux

# apts
apt-get install -y software-properties-common
add-apt-repository -y ppa:git-core/ppa
apt-get update
apt-get upgrade -y
apt-get install -y \
	autoconf \
	build-essential \
	clang \
	clangd \
	clang-format \
	cmake \
	curl \
	git \
	git-lfs \
	gpg \
	jq \
	libfuse-dev \
	libsqlite3-dev \
	libssl-dev \
	lldb \
	python3 \
	python3-pip \
	python3-pynvim \
	shellcheck \
	sqlite3 \
	tmux \
	trash-cli \
	unzip \
	wget \
	zip \
	zsh \
	ripgrep \
	gpg \
	bat \
	fd-find \
	xsel

apt remove neovim
# Docker
# https://docs.docker.com/engine/install/ubuntu/
# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
	tee /etc/apt/sources.list.d/docker.list >/dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
