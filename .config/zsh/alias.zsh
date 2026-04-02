#==============================================================#
##          Aliases                                           ##
#==============================================================#

# --- GNU (on macOS) ---
# Replace BSD commands with GNU versions
if [[ "$OSTYPE" == "darwin"* ]]; then
    # coreutils & findutils equivalents
    (( ${+commands[gdate]} ))    && alias date='gdate'
    (( ${+commands[gmkdir]} ))   && alias mkdir='gmkdir'
    (( ${+commands[gcp]} ))      && alias cp='gcp -i'
    (( ${+commands[gmv]} ))      && alias mv='gmv -i'
    (( ${+commands[grm]} ))      && alias rm='grm -i'
    (( ${+commands[gdu]} ))      && alias du='gdu'
    (( ${+commands[ghead]} ))    && alias head='ghead'
    (( ${+commands[gtail]} ))    && alias tail='gtail'
    (( ${+commands[gdirname]} )) && alias dirname='gdirname'
    (( ${+commands[gsed]} ))     && alias sed='gsed'
    (( ${+commands[ggrep]} ))    && alias grep='ggrep --color=auto'
    (( ${+commands[gfind]} ))    && alias find='gfind'
    (( ${+commands[gxargs]} ))   && alias xargs='gxargs'
    (( ${+commands[gawk]} ))     && alias awk='gawk'
    (( ${+commands[gtar]} ))     && alias tar='gtar'

    # ls configuration (fallback if eza is not used)
    if (( ${+commands[gls]} )); then
        alias ls='gls --color=auto --group-directories-first'
    else
        alias ls='ls -G'
    fi
fi

# --- LS (eza) ---
if (( ${+commands[eza]} )); then
    alias ls='eza --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias ll='eza -l --icons --git --group-directories-first'
    alias lla='eza -la --icons --git --group-directories-first'
    alias tree='eza --tree --icons'
fi

# --- CAT (bat) ---
if (( ${+commands[bat]} )); then
    alias cat='bat -pp --paging=never'
    alias b='bat'
fi

# --- CD (zoxide) ---
if (( ${+commands[zoxide]} )); then
    alias cd='z'
    alias cdi='zi' # interactive selection
fi

# --- Find/Search (fd/ripgrep) ---
if (( ${+commands[fdfind]} )); then
    alias fd='fdfind'
fi

# --- OS Specific ---
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias pp='pbcopy'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias pp='xsel --clipboard --input'
fi

# --- Shell Management ---
alias reload='exec $SHELL -l'
