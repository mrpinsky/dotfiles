alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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
