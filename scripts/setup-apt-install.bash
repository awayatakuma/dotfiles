#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

APT_LIST="${REPO_DIR}/.config/apt/Aptfile"

# 1. Prepare Repositories (PPA & Docker)
apt-get update
apt-get install -y software-properties-common curl ca-certificates

add-apt-repository -y ppa:zhangsongcui3371/fastfetch
add-apt-repository -y ppa:git-core/ppa
add-apt-repository -y ppa:longsleep/golang-backports

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
	tee /etc/apt/sources.list.d/docker.list >/dev/null

# 2. Single Update & Upgrade
apt-get update
apt-get upgrade -y

# 3. Bulk Install
xargs -a "$APT_LIST" apt-get install -y

# 4. Cleanup
apt-get remove neovim -y
