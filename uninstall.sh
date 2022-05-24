#!/bin/zsh

set -e

# Uninstall FZF
[[ -d ~/.fzf ]] && rm -rf ~/.fzf

# Uninstall Vim Plug and plugs
[[ -d ~/.vim ]] && rm -rf ~/.vim

[[ -f ~/.tmux.conf ]] && rm ~/.tmux.conf

[[ -d ~/fonts ]] || git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
pushd ~/fonts &> /dev/null
  chmod +x ./uninstall.sh
  ./uninstall.sh
popd
# rm -rf ~/fonts

rm -rf ~/.zshrc ~/.oh-my-zsh ~/.bash_profile
