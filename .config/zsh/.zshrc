source "$ZDOTDIR/zim.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/zeno.setting.zsh"

if [ -f "$ZDOTDIR/.zshenv.local" ]; then
    source "$ZDOTDIR/.zshenv.local"
fi

neofetch