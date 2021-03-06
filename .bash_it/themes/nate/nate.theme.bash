# ------------------------------------------------------------------#
#          FILE: nate.bash.theme                                    #
#            BY: Nate Pinsky                                        #
#      BASED ON: cooperkid by Alfredo Bejarano                      #
# ------------------------------------------------------------------#

SCM_THEME_PROMPT_DIRTY="${red} with changes${reset_color}"
SCM_THEME_PROMPT_CLEAN=" ${green}clean${reset_color}"
SCM_THEME_PROMPT_PREFIX=" "
SCM_THEME_PROMPT_SUFFIX=""
GIT_SHA_PREFIX="${blue}"
GIT_SHA_SUFFIX="${reset_color}"
RBENV_THEME_PROMPT_PREFIX="|"
SCM_GIT_STASH_CHAR_PREFIX="{"
SCM_GIT_STASH_CHAR_SUFFIX="}"
SCM_DETAILS=""

function git_prompt_info {
  git_prompt_vars
  echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}${SCM_DETAILS}"
}

function git_prompt_vars {
  SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  if [[ "$(git config --get bash-it.hide-status)" != "1" ]]; then
    [[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && local git_status_flags='-uno'
    local status_lines=$((git status --porcelain ${git_status_flags} -b 2> /dev/null ||
                          git status --porcelain ${git_status_flags}    2> /dev/null) | git_status_summary)
    local status=$(awk 'NR==1' <<< "$status_lines")
    local counts=$(awk 'NR==2' <<< "$status_lines")
    IFS=$'\t' read untracked_count unstaged_count staged_count <<< "$counts"
    if [[ "${untracked_count}" -gt 0 || "${unstaged_count}" -gt 0 || "${staged_count}" -gt 0 ]]; then
      SCM_DIRTY=1
      if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
        [[ "${staged_count}" -gt 0 ]] && SCM_DETAILS+=" ${green}${SCM_GIT_STAGED_CHAR}${staged_count}" && SCM_DIRTY=3
        [[ "${unstaged_count}" -gt 0 ]] && SCM_DETAILS+=" ${yellow}${SCM_GIT_UNSTAGED_CHAR}${unstaged_count}" && SCM_DIRTY=2
        [[ "${untracked_count}" -gt 0 ]] && SCM_DETAILS+=" ${red}${SCM_GIT_UNTRACKED_CHAR}${untracked_count}" && SCM_DIRTY=1
      fi
      SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
    fi
  fi
  [[ "${SCM_GIT_SHOW_CURRENT_USER}" == "true" ]] && SCM_DETAILS+="$(git_user_info)"
  SCM_CHANGE=$(git rev-parse --short HEAD 2>/dev/null)
  local ref=$(git_clean_branch)
  if [[ -n "$ref" ]]; then
    SCM_BRANCH="${SCM_THEME_BRANCH_PREFIX}${ref}"
    local tracking_info="$(grep -- "${SCM_BRANCH}\.\.\." <<< "${status}")"
    if [[ -n "${tracking_info}" ]]; then
      [[ "${tracking_info}" =~ .+\[gone\]$ ]] && local branch_gone="true"
      tracking_info=${tracking_info#\#\# ${SCM_BRANCH}...}
      tracking_info=${tracking_info% [*}
      local remote_name=${tracking_info%%/*}
      local remote_branch=${tracking_info#${remote_name}/}
      local remote_info=""
      local num_remotes=$(git remote | wc -l 2> /dev/null)
      [[ "${SCM_BRANCH}" = "${remote_branch}" ]] && local same_branch_name=true
      if ([[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "auto" ]] && [[ "${num_remotes}" -ge 2 ]]) ||
          [[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "true" ]]; then
        remote_info="${remote_name}"
        [[ "${same_branch_name}" != "true" ]] && remote_info+="/${remote_branch}"
      elif [[ ${same_branch_name} != "true" ]]; then
        remote_info="${remote_branch}"
      fi
      if [[ -n "${remote_info}" ]];then
        if [[ "${branch_gone}" = "true" ]]; then
          SCM_BRANCH+="${SCM_THEME_BRANCH_GONE_PREFIX}${remote_info}"
        else
          SCM_BRANCH+="${SCM_THEME_BRANCH_TRACK_PREFIX}${remote_info}"
        fi
      fi
    fi
    SCM_GIT_DETACHED="false"
  else
    local detached_prefix=""
    ref=$(git describe --tags --exact-match 2> /dev/null)
    if [[ -n "$ref" ]]; then
      detached_prefix=${SCM_THEME_TAG_PREFIX}
    else
      ref=$(git describe --contains --all HEAD 2> /dev/null)
      ref=${ref#remotes/}
      [[ -z "$ref" ]] && ref=${SCM_CHANGE}
      detached_prefix=${SCM_THEME_DETACHED_PREFIX}
    fi
    SCM_BRANCH=${detached_prefix}${ref}
    SCM_GIT_DETACHED="true"
  fi
  git_upstream_diff
  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
}

function git_upstream_diff() {
  local diffs=()
  local ahead_re='.+ahead ([0-9]+).+'
  local behind_re='.+behind ([0-9]+).+'
  [[ "${status}" =~ ${ahead_re} ]] && diffs=(${diffs[@]} "${blue}${SCM_GIT_AHEAD_CHAR}${BASH_REMATCH[1]}")
  [[ "${status}" =~ ${behind_re} ]] && diffs=(${diffs[@]} "${blue}${SCM_GIT_BEHIND_CHAR}${BASH_REMATCH[1]}")
  local stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
  [[ "${stash_count}" -gt 0 ]] && diffs=(${diffs[@]} "${blue}${SCM_GIT_STASH_CHAR_PREFIX}${stash_count}${SCM_GIT_STASH_CHAR_SUFFIX}")
  if [[ ${#diffs[@]} -gt 0 ]]; then
    SCM_BRANCH+="${blue} (${diffs[*]})${cyan}"
  fi
}

function git_short_sha() {
  SHA=$(git rev-parse --short HEAD 2> /dev/null) && echo "$GIT_SHA_PREFIX$SHA$GIT_SHA_SUFFIX"
}

function prompt() {
    local return_status=""
    local ruby="${red}$(ruby_version_prompt)${reset_color}"
    local user_host="${purple}\w${reset_color}"
    local git_branch="$(git_short_sha)${cyan}$(scm_prompt_info)"
    local prompt_symbol=' '
    local prompt_char_color="${purple}"
    if [[ $? = 1 ]]; then
      prompt_char_color=${red}
    fi
    local prompt_char="${prompt_char_color}>${orange} "

    PS1="\n${user_host}${prompt_symbol}${ruby} ${git_branch} ${return_status}\n${prompt_char}${reset_color}"
}

safe_append_prompt_command prompt
