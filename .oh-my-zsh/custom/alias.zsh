alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias be="bundle exec"
alias ber="clear && bundle exec rspec"
alias berf="clear && bundle exec rspec --fail-fast"
alias bern="clear && bundle exec rspec --next-failure"
alias bers="clear && bundle exec spring rspec"
alias berc="bundle exec spring rails console"
alias bes="bundle exec foreman start"

alias dc="docker-compose"

alias grm="git rebase origin/master"
alias grmi="git rebase origin/master -i"
alias gfrm="git fetch && git rebase origin/master"
alias gfrmi="git fetch && git rebase origin/master -i"

alias mt="mix test"
alias mtc="mix test --only current:true"
alias mti="iex -S mix test --trace --only current:true"
alias mps="mix phx.server"
alias mpsi="iex -S mix phx.server"

alias pe="pollev"
alias prodc="pollev exec -e production -t puma_general -c 'bundle exec rails console'"
alias stagingc="pollev exec -e staging -t puma_general -c 'bundle exec rails console'"
alias reviewc="pollev exec -e review -t puma_general -c 'bundle exec rails console'"

alias tn="tmux new"
alias tnt="tmux new -t"
alias ta="tmux attach"
alias tat="tmux attach -t"

alias vim="/usr/local/bin/vim"
