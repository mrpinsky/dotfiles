#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="/Users/nate/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='nate'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

alias cdr="cd ~/PollEverywhere/rails_app"
alias cdm="cd ~/PollEverywhere/mobile"
alias cdv="cd ~/PollEverywhere/viz"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
alias g=git
alias ga="git add"
alias gap="git add -p"
alias gd="git diff"
alias gdm="git diff origin/master"
alias gf="git fetch"
alias gl="git log origin/master.."
alias glp="git log -p origin/master.."
alias gmf="git merge --ff-only"
alias go="vim -o \$(git diff --name-only)"
alias gos="vim -o \$(git diff --name-only --staged)"
alias gpf="git push --force-with-lease"
alias gr="git rebase"
alias gri="git rebase -i"
alias grm="git fetch && git rebase origin/master"
alias grmi="git fetch && git rebase -i origin/master"
alias gv="g hist | vim -R -c 'set filetype=git' -"
__git_complete g __git_main

alias be="bundle exec"
alias ber="clear && bundle exec rspec"
alias berc="bundle exec rails console"
alias bes="bundle exec foreman start"

alias dc="docker-compose"

alias pe="pollev"
alias prodc="pollev exec -e production -t puma_general -c 'bundle exec rails console'"
alias stagingc="pollev exec -e staging -t puma_general -c 'bundle exec rails console'"
alias reviewc="pollev exec -e review -t puma_general -c 'bundle exec rails console'"

alias tn="tmux new"
alias tnt="tmux new -t"
alias ta="tmux attach"
alias tat="tmux attach -t"

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Homebrew path
#PATH=$PATH:/usr/local/bin

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
export PATH="$HOME/.pollev/bin:$PATH"
export EDITOR=vim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
ssh-add -K ~/.ssh/id_rsa
alias config='/usr/bin/git --git-dir=/Users/nate/.cfg/ --work-tree=/Users/nate'
