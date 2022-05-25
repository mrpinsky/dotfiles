#!/bin/zsh

set -e

git config --global --unset

# Uninstall Vim Plug and plugs
[[ -d ~/.vim ]] && rm -rf ~/.vim
[[ -f ~/.vimrc ]] && rm ~/.vimrc

# Uninstall FZF
[[ -d ~/.fzf ]] && rm -rf ~/.fzf

[[ -f ~/.tmux.conf ]] && rm ~/.tmux.conf
brew uninstall tmux

brew uninstall ag

[[ -d ~/fonts ]] || git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
pushd ~/fonts &> /dev/null
  chmod +x ./uninstall.sh
  ./uninstall.sh
popd
# rm -rf ~/fonts

which brew && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

rm -rf ~/.zshrc ~/.oh-my-zsh ~/.bash_profile
