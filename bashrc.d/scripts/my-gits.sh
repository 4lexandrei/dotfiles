#!/bin/bash

my-gits() {
  local github_username="4lexandrei"
  local github_urls="https://github.com/$github_username|git@github.com:$github_username"
  # Specify common directories with .git
  local dirs=(
    ~/.dotfiles
    ~/dev
  )

  # TODO: Test which repos script is more performant

  # local repos
  # repos=$(
  #   find "${dirs[@]}" -type f -path '*/.git/config' -exec grep -lE "url = ($github_urls)" {} + |
  #     sed 's|/\.git/config||'
  # )

  local repos
  repos=$(
    find "${dirs[@]}" -type f -path '*/.git/config' -print0 |
      xargs -0 grep -lE "url = ($github_urls)" |
      sed 's|/\.git/config||'
  )

  # shellcheck disable=SC2317
  FZF_PREVIEW_GIT() {
    local repo="$1"
    echo "$repo"
    echo "On branch: [ $(git -C "$repo" branch --show-current)]"
    git -C "$repo" status -b -u -s
  }

  export -f FZF_PREVIEW_GIT

  local selected_repo
  selected_repo=$(

    printf "%s\n" "${repos[@]}" | fzf --delimiter / --with-nth -1 \
      --preview 'FZF_PREVIEW_GIT {}' --preview-window=wrap
  )

  if [ -n "$selected_repo" ]; then
    cd "$selected_repo" && git status || echo "Failed to change directory."
  else
    echo "No repository selected."
  fi
}
