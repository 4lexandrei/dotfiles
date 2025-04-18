#!/bin/bash
# validator.sh
# Validates if path is safe to get modified
# Usage: validate_path <path>

VALIDATOR_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$VALIDATOR_SCRIPT_DIR/helpers.sh" || exit 1
source "$VALIDATOR_SCRIPT_DIR/log.sh" || exit 1

check_function "log"

readonly ALLOWED_PATH_BASES=(
  "$HOME/.config"
  "$HOME/.local/bin"
  "$HOME/.local/share/applications"
  "$HOME/.local/share/fonts"
)

validate_path() {
  local path="$1"
  path=$(realpath --no-symlinks "$HOME/$path")

  if [[ "$path" == "$HOME/.bashrc" ]]; then
    # Uncomment for debugging
    # printf "[PASSED] %s is safe to remove or modify\n" "$path"
    return 0
  fi

  for base in "${ALLOWED_PATH_BASES[@]}"; do
    base=$(realpath --no-symlinks "$base")
    if [[ "$path" == "$base" ]]; then
      log error "Blocked: $path is not a safe path"
      return 1
    fi

    if [[ "$path" == "$base"/* ]]; then
      # Uncomment for debugging
      # printf "[PASSED] %s is safe to remove or modify\n" "$path"
      return 0
    fi
  done

  log error "Blocked: $path is not a safe path"

  return 1
}
