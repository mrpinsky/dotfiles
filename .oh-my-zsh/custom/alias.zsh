alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias be="bundle exec"
alias ber="bundle exec rspec"
alias berf="bundle exec rspec --fail-fast"
alias bern="bundle exec rspec --next-failure"
alias bers="bundle exec spring rspec"
alias berc="bundle exec spring rails console"
alias sandbox="bundle exec spring rails console --sandbox"
alias bes="bundle exec foreman start"

alias dc="docker-compose"

alias grm="git rebase origin/master"
alias grmi="git rebase origin/master -i"
alias gfrm="git fetch && git rebase origin/master"
alias gfrmi="git fetch && git rebase origin/master -i"
alias gv="g hist | vim -R -c 'set filetype=git' -"

alias gig=gigalixir

alias mt="mix test"
alias mtc="mix test --only current:true"
alias mti="iex -S mix test --trace --only current:true"
alias mps="mix phx.server"
alias mpsi="iex -S mix phx.server"

alias pe="pollev"
alias pesh="pollev sh -i"

alias prodc="pollev exec -e production -t puma_general -c 'bundle exec rails console'"
alias prods="pollev exec -e production -t puma_general -c 'bundle exec rails console --sandbox'"
alias prodsh="pollev exec -e production -t puma_general -c bash"
alias proddb="pollev database tunnel -p 3309 rails-app production"

alias stagingc="pollev exec -e staging -t puma-general -c 'bundle exec rails console'"
alias stagings="pollev exec -e production -t puma-general -c 'bundle exec rails console --sandbox'"
alias stagingsh="pollev v2 app shell -a rails-app -e staging -n puma-general -s bash"
alias stagingdb="pollev database tunnel -p 3309 rails-app staging"

alias reviewc="pollev exec -e review -t puma_general -c 'bundle exec rails console'"
alias reviews="pollev exec -e review -t puma_general -c 'bundle exec rails console --sandbox'"
alias reviewsh="pollev exec -e review -t puma_general -c bash"
alias reviewdb="pollev database tunnel -p 3309 rails-app review"

alias tn="tmux new"
alias tnt="tmux new -t"
alias ta="tmux attach"
alias tat="tmux attach -t"

alias vim="/usr/local/bin/vim"
