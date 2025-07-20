#==============================================================#
##          Functions                                         ##
#==============================================================#

mkd() {
    if [[ "$#" -eq 0 ]]; then
        echo "mkdir: missing operand"
    else
        command mkdir -p "$@"
    fi
}


rmr() {
    if [[ "$#" -eq 0 ]]; then
        echo "rm -rf: missing operand"
    else
        command rm -rf "$@"
    fi
}

# https://www.m3tech.blog/entry/dotfiles-bonsai
# [[ --
docker() {
    if [ "$1" = "compose" ] || ! command -v "docker-$1" >/dev/null; then
        command docker "${@:1}" # 通常通りdockerコマンドを呼び出す
    else
        "docker-$1" "${@:2}" # docker-foo というコマンドが存在するときはそちらを起動する
    fi
}

# docker clean
# ExitedなDockerプロセスをすべて削除する
docker-clean() {
    command docker ps -aqf status=exited | xargs -r docker rm --
}

# docker cleani
# UntaggedなDockerイメージをすべて削除する
docker-cleani() {
    command docker images -qf dangling=true | xargs -r docker rmi --
}

# docker rm (上書き)
# 引数なしで docker rm したときはプロセスをFZFで選択して削除する
docker-rm() {
    if [ "$#" -eq 0 ]; then
        command docker ps -a | fzf --exit-0 --multi --header-lines=1 | awk '{ print $1 }' | xargs -r docker rm --
    else
        command docker rm "$@"
    fi
}

# docker rmi (上書き)
# 引数なしで docker rmi したときはイメージをFZFで選択して削除する
docker-rmi() {
    if [ "$#" -eq 0 ]; then
        command docker images | fzf --exit-0 --multi --header-lines=1 | awk '{ print $3 }' | xargs -r docker rmi --
    else
        command docker rmi "$@"
    fi
}

# --]]

# Git convenience functions
gacp() {
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: gacp <commit message>"
        return 1
    fi
    git add . && git commit -m "$*" && git push
}

# Create directory and change into it
mcd() {
    mkdir -p "$1" && cd "$1"
}

# Find and change to directory
ff() {
    local dir
    dir=$(find . -type d 2>/dev/null | fzf +m) && cd "$dir"
}

# Find and kill process
pk() {
    local pid
    pid=$(ps -ef | grep -v grep | fzf | awk '{print $2}')
    [ -n "$pid" ] && kill -${1:-9} "$pid"
}

# Pretty print JSON
json() {
    if [ -t 0 ]; then
        python3 -m json.tool <<< "$*"
    else
        python3 -m json.tool
    fi
}

# Start simple HTTP server
serve() {
    local port=${1:-8000}
    python3 -m http.server "$port"
}


# Display disk usage sorted by size
dus() {
    du -sh ${1:-.}/* 2>/dev/null | sort -hr
}

# Extract archives automatically
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1" ;;
            *.tar.gz)    tar xzf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.tar)       tar xf "$1" ;;
            *.tbz2)      tar xjf "$1" ;;
            *.tgz)       tar xzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1" ;;
            *)           echo "'$1' is not a supported format" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Check IP addresses
myip() {
    echo -n "Local IP: "
    ip route get 1.1.1.1 | awk '{print $7}' | head -1
    echo -n "Global IP: "
    curl -s ipinfo.io/ip
}

# Create backup file/directory with timestamp
backup() {
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: backup <file|directory>"
        return 1
    fi
    if [[ ! -e "$1" ]]; then
        echo "Error: '$1' does not exist"
        return 1
    fi
    cp -r "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
    echo "Backup created: $1.backup-$(date +%Y%m%d-%H%M%S)"
}


# Generate random password
genpass() {
    local length=${1:-16}
    openssl rand -base64 $((length * 3 / 4)) | tr -d "=+/" | cut -c1-${length}
}

# Select git branch with fzf and checkout
gbr() {
    local branch
    branch=$(git branch -a | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | fzf)
    [ -n "$branch" ] && git checkout "$branch"
}

# AWS convenience functions
# Switch AWS profile
awsp() {
    if [[ "$#" -eq 0 ]]; then
        aws configure list-profiles | fzf | read -r profile
    else
        profile="$1"
    fi
    [ -n "$profile" ] && export AWS_PROFILE="$profile" && echo "AWS profile set to: $profile"
}

# Development convenience functions
# Quick project finder and opener
proj() {
    local project_dir="${PROJECT_DIR:-$HOME/projects}"
    local project
    project=$(find "$project_dir" -maxdepth 2 -type d -name ".git" | sed 's|/.git||' | fzf)
    [ -n "$project" ] && cd "$project"
}

# Port checker
port() {
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: port <port_number>"
        return 1
    fi
    lsof -i ":$1" || echo "Port $1 is not in use"
}

# Kill process by port
killport() {
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: killport <port_number>"
        return 1
    fi
    local pid=$(lsof -ti ":$1")
    [ -n "$pid" ] && kill -9 "$pid" && echo "Killed process on port $1" || echo "No process found on port $1"
}

# Quick weather check
weather() {
    local city="${1:-Tokyo}"
    curl -s "wttr.in/$city?format=3"
}

netinfo() {
    echo "=== Network Information ==="
    echo -n "External IP: "
    curl -s ipinfo.io/ip
    echo -n "Local IP: "
    ip route get 1.1.1.1 | awk '{print $7}' | head -1
    echo "DNS Servers:"
    cat /etc/resolv.conf | grep nameserver | awk '{print "  " $2}'
    echo "Active connections:"
    ss -tuln | head -10
}

zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|history|lazygit|la|ll|ls|rm|rmdir|trash|es|ee|eea)($| )" ]]
}
