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

alias git=/usr/local/bin/git
alias g=git
alias grm="git rebase origin/master"
alias grmi="git rebase origin/master -i"
alias gfrm="git fetch && git rebase origin/master"
alias gfrmi="git fetch && git rebase origin/master -i"
alias gv="g hist | vim -R -c 'set filetype=git' -"
alias gss="git rev-parse --short head 2> /dev/null"
alias reviewer='gh api --paginate repos/:owner/:repo/collaborators | jq ".[].login" | tr -d \" | fzf'

alias gig=gigalixir

alias k=kubectl

alias mt="mix test"
alias mtc="mix test --only current:true"
alias mti="iex -S mix test --trace --only current:true"
alias mps="mix phx.server"
alias mpsi="iex -S mix phx.server"

alias pe="pollev"
alias pollev="nocorrect pollev"
alias pesh="pollev sh -i"
alias pd="pollev deploy"
alias pdp="pollev deploy -e production"

alias prodsh="pollev v2 app shell -a rails-app -e production -n puma-general -s bash"
alias proddb="ssh prod-sql"

alias stagingsh="pollev v2 app shell -a rails-app -e staging -n puma-general -s bash"
alias stagingdb="pollev database tunnel -p 3309 rails-app staging"

alias reviewsh="pollev v2 app shell -a rails-app -e review -n puma-general -s bash"
alias reviewdb="pollev database tunnel -p 3309 rails-app review"

alias tn="tmux new"
alias tnt="tmux new -At"
alias ta="tmux attach"
alias tat="tmux attach -t"

alias vim="/usr/local/bin/vim"

alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'
