#!/bin/bash
# check if a sourced function is available otherwise exit

RED=$(tput setaf 1)
NC=$(tput sgr0)

check_function() {
  for function in "$@"; do
    if ! declare -f "$function" >/dev/null; then
      printf "%sERROR%s Function '%s' is not declared\n" "${RED}" "${NC}" "$function" >&2
      exit 1
    fi
  done
}
