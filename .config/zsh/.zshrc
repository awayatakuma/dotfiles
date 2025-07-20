source "$ZDOTDIR/zim.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/zeno.setting.zsh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use "$NODE_VERSION"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -f "$ZDOTDIR/.zshenv.local" ]; then
    source "$ZDOTDIR/.zshenv.local"
fi

neofetch