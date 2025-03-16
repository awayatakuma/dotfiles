#!/usr/bin/env bash
set -eux

# apts
apt-get install -y software-properties-common
add-apt-repository -y ppa:git-core/ppa
add-apt-repository -y ppa:longsleep/golang-backports

apt-get update
apt-get upgrade -y
apt-get install -y \
	autoconf \
	bat \
	build-essential \
	clang \
	clang-format \
	clangd \
	cmake \
	curl \
	eza \
	fd-find \
	gcc \
	git \
	git-lfs \
	gpg \
	jq \
	libasound2-dev \
	libexpat1-dev \
	libfontconfig1-dev \
	libfreetype6-dev \
	libfuse-dev \
	libsqlite3-dev \
	libssl-dev \
	libx11-dev \
	libxcb-composite0-dev \
	lldb \
	neofetch  \
	openssl \
	pkg-config \
	python3 \
	python3-pip \
	python3-pynvim \
	ripgrep \
	shellcheck \
	sqlite3 \
	tmux \
	trash-cli \
	unzip \
	vim \
	wget \
	xsel \
	zip \
	zsh

apt remove neovim -y

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