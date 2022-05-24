#!/bin/zsh

set -e

function link_to_home() {
  ln -sfv "$HOME/dotfiles/$1" "$HOME/$1"
}

### SHELL ###
if [[ "$SHELL" =~ "zsh" ]]; then
  # Install Oh My Zsh
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &>/dev/null

  link_to_home .zshrc
elif [[ "$SHELL" =~ "bash" ]]; then
  link_to_home .bash_profile
else
  echo "Unknown shell $SHELL"
fi

### FONTS ###
[[ -d ~/fonts ]] || git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts &>/dev/null
pushd ~/fonts &> /dev/null
  ./install.sh
popd

### TMUX ###
link_to_home .tmux.conf

### FZF ###
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &>/dev/null
~/.fzf/install --no-bash --no-fish --key-bindings --completion --no-update-rc

### VIM ###
link_to_home .vimrc

# Install Vim Plug
# From https://github.com/junegunn/vim-plug#unix
[[ -d ~/.vim ]] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &>/dev/null

# Install 
vim -u ~/dotfiles/plugs.vim -c PlugInstall -c qa &>/dev/null
