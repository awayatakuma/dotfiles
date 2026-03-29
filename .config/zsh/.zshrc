source "$ZDOTDIR/zim.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/zeno.setting.zsh"


if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

neofetch