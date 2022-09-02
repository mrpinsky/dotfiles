#!/bin/zsh

set -e

function link_to_home() {
  ln -sfv "$HOME/dotfiles/$1" "$HOME/$1"
}

### SHELL ###
echo "SHELL"
if [[ "$SHELL" =~ "zsh" ]]; then
  # Install Oh My Zsh
  echo installing omz
  [[ -d ~/.oh-my-zsh ]] || git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &>/dev/null

  echo zshrc
  echo "source ~/dotfiles/.zshrc" >> ~/.zshrc
elif [[ "$SHELL" =~ "bash" ]]; then
  echo bash_profile
  echo "source ~/dotfiles/.bash_profile" >> ~/.bash_profile
else
  echo "Unknown shell $SHELL"
fi

### FONTS ###
echo "FONTS"
[[ -d ~/fonts ]] || git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts &>/dev/null
pushd ~/fonts &> /dev/null
  ./install.sh
popd

### HOMEBREW ###
echo "HOMEBREW"
if ! which brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "Homebrew installed."
  echo "Open a new terminal to continue with installation"
  exit 0
fi

### GIT ###
# Install git via homebrew for version management
echo GIT
brew install --quiet git

### TMUX ###
echo "TMUX"
echo "source-file ~/dotfiles/.tmux.conf" >> ~/.tmux.conf
brew install --quiet tmux

### AG ###
echo "AG"
brew install --quiet ag

### GH ###
echo "GH"
brew install --quiet gh

### FZF ###
echo FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &>/dev/null
~/.fzf/install --no-bash --no-fish --key-bindings --completion --no-update-rc

### VIM ###
echo VIM
link_to_home .vimrc

# Install Vim Plug
echo VIM PLUG
# From https://github.com/junegunn/vim-plug#unix
[[ -d ~/.vim ]] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &>/dev/null

# Install 
echo PLUG INSTALL
vim -u ~/dotfiles/plugs.vim -c PlugInstall -c qa &>/dev/null

echo GIT CONFIG
git config --global --add include.path "$HOME/dotfiles/gitconfig"
