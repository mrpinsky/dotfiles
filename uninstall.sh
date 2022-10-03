#!/bin/zsh

set -e

git config --global --unset

# Clean up kitty
brew uninstall --cask kitty
if [[ -d ~/.config/kitty ]]; then
  for file in $(ls "$HOME/dotfiles/kitty/"); do
    rm "$HOME/dotfiles/kitty/$file"
  done
fi

# Uninstall Vim Plug and plugs
[[ -d ~/.vim ]] && rm -rf ~/.vim
brew uninstall nvim
[[-d ~/.config/nvim ]] && rm -rf ~/.config/nvim
[[ -f ~/.vimrc ]] && rm ~/.vimrc

# Uninstall FZF
[[ -d ~/.fzf ]] && rm -rf ~/.fzf

if [[ -f ~/.tmux.conf ]]; then
  grep -v "~/dotfiles/.tmux.conf" ~/.tmux.conf > ~/.tmux.conf.clean
  mv ~/.tmux.conf.clean ~/.tmux.conf
fi
brew uninstall tmux

brew uninstall gh
brew uninstall ag

[[ -d ~/fonts ]] || git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
pushd ~/fonts &> /dev/null
  chmod +x ./uninstall.sh
  ./uninstall.sh
popd
# rm -rf ~/fonts

which brew && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

if [[ -f ~/.zshrc ]]; then
  grep -v "~/dotfiles/.zshrc" ~/.zshrc > ~/.zshrc.clean
  mv ~/.zshrc.clean ~/.zshrc
fi
if [[ -f ~/.bash_profile ]]; then
  grep -v "~/dotfiles/.bash_profile" ~/.bash_profile > ~/.bash_profile.clean
  mv ~/.bash_profile.clean ~/.bash_profile
fi
rm -rf ~/.oh-my-zsh
