#!/bin/bash

my-gits() {
  local github_username="4lexandrei"
  local github_urls="https://github.com/$github_username|git@github.com:$github_username"
  # Specify common directories with .git
  local dirs=(
    ~/.dotfiles
    ~/dev
  )

  select_repo=$(find "${dirs[@]}" -type f -path '*/.git/config' -exec grep -lE "url = ($github_urls)" {} + |
    sed 's|/\.git/config||' |
    fzf)

  if [ -n "$select_repo" ]; then
    cd "$select_repo" && git status || echo "Failed to change directory"
  else
    echo "No repository selected"
  fi
}
