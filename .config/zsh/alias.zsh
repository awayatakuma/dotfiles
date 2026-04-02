#==============================================================#
##          Aliases                                           ##
#==============================================================#

# --- LS (eza) ---
if (( ${+commands[eza]} )); then
    alias ls='eza --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias ll='eza -l --icons --git --group-directories-first'
    alias lla='eza -la --icons --git --group-directories-first'
    alias tree='eza --tree --icons'
else
    alias la='ls -aF --color=auto'
    alias lla='ls -alF --color=auto'
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
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
# Note: Debian/Ubuntu specific naming handling for fd is kept for compatibility
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
