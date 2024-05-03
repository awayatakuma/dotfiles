#==============================================================#
##          Functions                                         ##
#==============================================================#

mkd() {
    if [[ "$#" -eq 0 ]]; then
        echo "mkdir: オペランドがありません"
    else
        command mkdir -p "$@"
    fi
}


rmr() {
    if [[ "$#" -eq 0 ]]; then
        echo "rm -rf: オペランドがありません"
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
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|history|lazygit|la|ll|ls|rm|rmdir|trash|es|ee|eea)($| )" ]]
}
