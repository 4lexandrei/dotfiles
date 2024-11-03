#!/bin/bash

my-gits() {
  local github_username="4lexandrei"
  local github_urls="https://github.com/$github_username|git@github.com:$github_username"

  select_repo=$(find ~ -type f -path '*/.git/config' -exec grep -lE "url = ($github_urls)" {} + |
    sed 's|/\.git/config||' |
    fzf)

  if [ -n "$select_repo" ]; then
    cd "$select_repo" && git status || echo "Failed to change directory"
  else
    echo "No repository selected"
  fi
}
