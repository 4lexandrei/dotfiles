#!/usr/bin/env bash

path_has() {
  [[ "$PATH" =~ (^|:)$1(:|$) ]]
}

path_prepend() {
  local d

  for d in "$@"; do
    [[ -d "$d" ]] || continue
    path_has "$d" || PATH="$d:$PATH"
  done

  export PATH
}

path_append() {
  local d

  for d in "$@"; do
    [[ -d "$d" ]] || continue
    path_has "$d" || PATH="$PATH:$d"
  done

  export PATH
}
