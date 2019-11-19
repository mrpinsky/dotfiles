function my_git_prompt() {
  INDEX=$(command git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  commits_ahead=$(git log --pretty=oneline origin/$(git_current_branch)..HEAD 2> /dev/null | wc -l | tr -d ' ')
  if [[ $commits_ahead -gt 0 ]]; then
    STATUS="$STATUS %{$fg[green]%}$commits_ahead$ZSH_THEME_GIT_PROMPT_AHEAD%{$reset_colors%}"
  fi

  # is branch behind?
  commits_behind=$(git log --pretty=oneline HEAD..origin/$(git_current_branch) 2> /dev/null | wc -l | tr -d ' ')
  if [[ $commits_behind -gt 0 ]]; then
    STATUS="$STATUS %{$fg[yellow]%}$commits_behind$ZSH_THEME_GIT_PROMPT_BEHIND%{$reset_colors%}"
  fi

  # is anything staged?
  staged_files_count=$(echo "$INDEX" | command grep -E -e '^D[ M]|[MARC][ MD] ' 2> /dev/null | wc -l | tr -d ' ')
  if [[ $staged_files_count -gt 0 ]]; then
    STATUS="$STATUS %{$fg[green]%}$staged_files_count$ZSH_THEME_GIT_PROMPT_FILE_STATUS_SYMBOL%{$reset_colors%}"
  fi

  # is anything unstaged?
  unstaged_files_count=$(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' 2> /dev/null | wc -l | tr -d ' ')
  if [[ $unstaged_files_count -gt 0 ]]; then
    STATUS="$STATUS %{$fg[yellow]%}$unstaged_files_count$ZSH_THEME_GIT_PROMPT_FILE_STATUS_SYMBOL%{$reset_colors%}"
  fi

  # is anything untracked?
  untracked_files_count=$(echo "$INDEX" | command grep '^?? ' 2> /dev/null | wc -l | tr -d ' ')
  if [[ $untracked_files_count -gt 0 ]]; then
    STATUS="$STATUS %{$fg[red]%}$untracked_files_count$ZSH_THEME_GIT_PROMPT_FILE_STATUS_SYMBOL%{$reset_colors%}"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  # is anything stashed?
  stash_count=$(command git stash list 2> /dev/null | grep '^stash@{' | wc -l | tr -d ' ')
  if [[ $stash_count -gt 0 ]]; then
    STATUS="$STATUS %{$fg[blue]%}{$stash_count}%{$reset_colors%}"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch) %{$fg_no_bold[blue]%}($(git_short_sha))%{$reset_colors%}$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(git_current_branch || echo "(no git)")
}

function git_short_sha() {
  echo $(git rev-parse --short HEAD 2> /dev/null)
}

local prompt_char="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%#%{$reset_color%}"
PROMPT=$'\n%{$fg_bold[yellow]%}%*%{$reset_color%} %{$fg_bold[magenta]%}%1~%{$reset_color%} $(my_git_prompt) \n${prompt_char} '
RPROMPT=""

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[green]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_FILE_STATUS_SYMBOL="●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
