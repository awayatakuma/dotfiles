#==============================================================#
##          Aliases                                           ##
#==============================================================#

# ls
alias la='ls -aF --color=auto'
alias lla='ls -alF --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'

# eza
if (( ${+commands[eza]} )); then
    alias es='eza --color --group-directories-first'
    alias ea='eza --color --group-directories-first -a'
    alias eea='eza --color --group-directories-first -alF --header --color-scale --git --icons --time-style=long-iso'
    alias ee='eza --color --group-directories-first -lF --header --color-scale --git --icons --time-style=long-iso'
    alias tree='eza --color --group-directories-first --tree --icons'
fi

# Modern CLI tool aliases (Debian/Ubuntu naming compatibility)
if (( ${+commands[batcat]} )); then
    alias bat='batcat'
fi

if (( ${+commands[fdfind]} )); then
    alias fd='fdfind'
fi

# ripgrep available as rg (don't replace grep to avoid compatibility issues)

# others
alias pp='xsel --clipboard --input'
alias reload='exec $SHELL -l'
alias v='nvim'
alias zl='zellij'
alias lg='lazygit'