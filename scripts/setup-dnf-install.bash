#!/usr/bin/env bash
set -eux

# dnf
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
dnf config-manager --set-enabled crb
dnf install -y epel-release
dnf install -y epel-next-release

dnf remove -y curl-minimal neovim

dnf update -y
dnf upgrade -y
dnf install -y \
	autoconf \
	bat \
	clang \
	clang-tools-extra \
	cmake \
	curl \
	fd-find \
	gcc \
	git \
	git-lfs \
	gnupg \
	jq \
	libX11-devel \
	libXcomposite-devel \
	expat-devel \
	fontconfig-devel \
	freetype-devel \
	fuse-devel \
	sqlite-devel \
	openssl-devel \
	lldb \
	neofetch \
	openssl \
	pkg-config \
	python3 \
	python3-pip \
	ripgrep \
	ShellCheck \
	sqlite \
	tmux \
	trash-cli \
	unzip \
	vim \
	wget \
	xsel \
	zip \
	zsh

# https://docs.docker.com/engine/install/rhel/
# Add Docker's official GPG key:
dnf update
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

dnf update
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin