# Load fzf
source "$XDG_DATA_HOME/.fzf/shell/completion.zsh"

# fzf configuration - use fdfind (Debian/Ubuntu) or fd
if command -v fdfind >/dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
elif command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
else
    export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='find . -type d -not -path "*/\.git/*"'
fi

# Load key-bindings after configuration
source "$XDG_DATA_HOME/.fzf/shell/key-bindings.zsh"

# Alternative keybindings to avoid conflicts with editors
bindkey '^[f' fzf-file-widget     # Alt-F for files (instead of Ctrl-T)
bindkey '^[d' fzf-cd-widget       # Alt-D for directories (instead of Alt-C)

# Advanced fzf options with preview and colors
export FZF_DEFAULT_OPTS="
  --height 90%
  --layout=reverse
  --border=rounded
  --info=inline
  --margin=0
  --padding=0
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --bind 'alt-p:toggle-preview'
  --bind 'alt-u:preview-up'
  --bind 'alt-j:preview-down'
  --bind 'alt-a:select-all'
  --bind 'alt-t:toggle-all'
  --bind 'alt-y:execute-silent(echo {+} | xsel --clipboard)'
"

# File search with preview - use batcat (Debian/Ubuntu) or bat
if command -v batcat >/dev/null; then
    export FZF_CTRL_T_OPTS="
      --preview 'batcat --color=always --style=numbers --line-range=:500 {}'
      --preview-window 'right:40%:wrap'
    "
elif command -v bat >/dev/null; then
    export FZF_CTRL_T_OPTS="
      --preview 'bat --color=always --style=numbers --line-range=:500 {}'
      --preview-window 'right:40%:wrap'
    "
else
    export FZF_CTRL_T_OPTS="
      --preview 'head -500 {}'
      --preview-window 'right:40%:wrap'
    "
fi

# Directory search with tree preview - fallback to ls if eza not available
if command -v eza >/dev/null; then
    export FZF_ALT_C_OPTS="
      --preview 'eza --tree --color=always {} | head -200'
      --preview-window 'right:40%:wrap'
    "
elif command -v tree >/dev/null; then
    export FZF_ALT_C_OPTS="
      --preview 'tree -C {} | head -200'
      --preview-window 'right:40%:wrap'
    "
else
    export FZF_ALT_C_OPTS="
      --preview 'ls -la {}'
      --preview-window 'right:40%:wrap'
    "
fi

# History search improvements
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window 'down:2:wrap'
  --bind 'alt-y:execute-silent(echo -n {2..} | xsel --clipboard)'
"

# Custom fzf functions
# Git file selector with preview
fzf-git-files() {
  git ls-files | fzf \
    --preview 'bat --color=always --style=numbers {}' \
    --preview-window 'right:60%:wrap' \
    --header 'Git Files' \
    --bind 'enter:execute(echo {})+abort'
}

# Process finder with details
fzf-processes() {
  ps -eo pid,ppid,user,%cpu,%mem,time,comm --sort=-%cpu | 
  fzf --header-lines=1 \
      --preview 'echo {}' \
      --preview-window 'down:2:wrap' \
      --bind 'enter:execute(kill {1})'
}

# Enhanced history search
fzf-history() {
  history | fzf --tac --no-sort \
    --preview 'echo {}' \
    --preview-window 'down:2:wrap' \
    --bind 'enter:execute(echo {2..})+abort'
}

# Docker container selector
fzf-docker() {
  docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" |
  fzf --header-lines=1 \
      --preview 'docker inspect {1}' \
      --preview-window 'right:40%:wrap' \
      --bind 'enter:execute(docker exec -it {1} /bin/bash)+abort'
}

# Package search (if using apt/dnf)
fzf-packages() {
  if command -v apt >/dev/null; then
    apt list 2>/dev/null | fzf \
      --preview 'apt show {1}' \
      --preview-window 'right:40%:wrap'
  elif command -v dnf >/dev/null; then
    dnf list available | fzf \
      --preview 'dnf info {1}' \
      --preview-window 'right:40%:wrap'
  fi
}

# Key bindings for custom functions (using Alt combinations)
bindkey -s '^[gf' 'fzf-git-files\n'      # Alt-G F
bindkey -s '^[gp' 'fzf-processes\n'      # Alt-G P
bindkey -s '^[gh' 'fzf-history\n'        # Alt-G H
bindkey -s '^[gd' 'fzf-docker\n'         # Alt-G D
