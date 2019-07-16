# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

ssh-add -K ~/.ssh/id_rsa &> /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
