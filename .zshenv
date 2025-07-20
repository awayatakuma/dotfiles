typeset -gU PATH path

### locale ###
export LANG="en_US.UTF-8"

### XDG ###
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZRCDIR="$ZDOTDIR/rc"

# Env Paths
# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Deno
export DENO_HOME="$XDG_DATA_HOME/deno"
DENO_NO_UPDATE_CHECK=1

# Go
export GOPATH="$XDG_DATA_HOME/go"

#Dotnet
export DOTNET_ROOT="$XDG_DATA_HOME/.dotnet"

#nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NODE_VERSION="${NODE_VERSION:-v22.17.0}"

# History
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=12000
export SAVEHIST=10000

setopt APPEND_HISTORY
setopt AUTO_PUSHD
setopt EXTENDED_HISTORY
setopt GLOBDOTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE 
setopt HIST_SAVE_NO_DUPS 
setopt SHARE_HISTORY 

#Others
export DOCKER_CONFIG="$XDG_DATA_HOME/docker"
export FZF_HOME="$XDG_DATA_HOME/.fzf/"


path=(
    "$NVM_DIR/versions/node/$NODE_VERSION/bin"(N-/)
    '/usr/local/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/local/sbin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
    "$HOME/.local/bin"(N-/)
    "$CARGO_HOME/bin"(N-/)
    "$GOPATH/bin"(N-/)
    "$DENO_HOME/bin"(N-/)
    "$DOTNET_ROOT"
    "$DOTNET_ROOT/tools"
    "$FZF_HOME/bin"(N-/)
    "$path[@]"
)

source "${CARGO_HOME}/env"
