# Aliases and helpers.
#
# Everything above the guard loads in every shell, including Claude Code's `!`
# mode. Agents never type these names, so they can't change agent behaviour.
# Anything that changes how a *standard* command behaves goes below the guard.

# --- Editor ------------------------------------------------------------------
alias vim=nvim
alias vi=nvim

# --- Listing / navigation -----------------------------------------------------
# (prezto's utility module provides ls colours plus l, ll, la, lt)
alias cl=clear

# --- Git -----------------------------------------------------------------------
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add -A'
alias gap='git add -p'
alias gc='git commit'
alias gcm='git commit -m'
alias gam='git commit --amend'
alias gco='git checkout'
alias gsw='git switch'
alias gnb='git switch -c'
alias gb='git branch -v'
alias grb='git recent-branches'
alias gl='git l'
alias gps='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gst='git stash'
alias gsp='git stash pop'
alias grs='git reset'
alias gunc='git uncommit'
alias gwt='git worktree list'

# --- Agents ------------------------------------------------------------------

# wt <branch> [base]: create (or reuse) a git worktree next to the repo and cd
# into it, so an agent can work on <branch> without touching your checkout.
#   ~/Code/app  +  wt fix-login  ->  ~/Code/app-worktrees/fix-login
wt() {
  local branch=$1 base=${2:-HEAD}
  [[ -z $branch ]] && { echo "usage: wt <branch> [base]"; return 1; }
  local root; root=$(git rev-parse --show-toplevel) || return 1
  local dir="${root}-worktrees/${branch//\//-}"
  if [[ ! -d $dir ]]; then
    if git show-ref --quiet --verify "refs/heads/$branch"; then
      git worktree add "$dir" "$branch" || return 1
    else
      git worktree add -b "$branch" "$dir" "$base" || return 1
    fi
  fi
  cd "$dir"
}

# wtrm [branch]: remove a worktree (defaults to the current one).
wtrm() {
  local dir
  if [[ -n $1 ]]; then
    dir="$(git rev-parse --show-toplevel | sed 's/-worktrees\/.*//')-worktrees/${1//\//-}"
  else
    dir=$(git rev-parse --show-toplevel) || return 1
    cd "$(git worktree list --porcelain | awk '/^worktree /{print $2; exit}')"
  fi
  git worktree remove "$dir"
}

# --- Human-only ----------------------------------------------------------------
[[ -n $YADR_AGENT_SHELL ]] && return

# Don't glob for git (so `git add *foo*` passes the pattern through to git).
alias git='noglob git'

autoload -U zmv
alias zmv='noglob zmv -W'

alias -g ...='../..'
alias -g ....='../../..'
