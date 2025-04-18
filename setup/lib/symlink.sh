#!/bin/bash
# symlink.sh
# Symlinker script to create symbolic links for dotfiles
# Usage: symlink <target> <link>

set -o errexit

SYMLINK_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_PATH="$(realpath "$SYMLINK_SCRIPT_DIR/../..")"

source "$SYMLINK_SCRIPT_DIR/helpers.sh" || exit 1
source "$SYMLINK_SCRIPT_DIR/log.sh" || exit 1
source "$SYMLINK_SCRIPT_DIR/validator.sh" || exit 1

check_function "validate_path" "log"

symlink() {
  if [[ -z "$1" || -z "$2" ]]; then
    log error "Usage: symlink <target> <link>"
    return 1
  fi

  local target="$1"
  local link="$2"

  # Link validation
  if ! validate_path "$link"; then
    log error "Link path '$link' is not safe to modify"
    return 1
  fi

  target=$DOTFILES_PATH/$target
  link=$HOME/$link

  # Ensure target exists
  if [[ ! -e "$target" ]]; then
    log error "Target '$target' does not exists"
    return 1
  fi

  local resolved_target
  resolved_target=$(realpath "$target")

  if [[ "$resolved_target" != "$DOTFILES_PATH"* ]]; then
    log error "Target '$resolved_target' is outside of DOTFILES_PATH"
    return 1
  fi

  local display_target="${target/#$DOTFILES_PATH/.dotfiles}"
  local display_link="~${link/#$HOME/}"

  # Handle existing links or directories
  if [[ -e "$link" || -L "$link" ]]; then
    # Overwrite symlink
    rm -rf "$link"
    ln -snf "$target" "$link"

    log info "Overwritten $display_link:"
    printf "%s -> %s\n" "$display_target" "$display_link"
  else
    # Create the symlink
    ln -snf "$target" "$link"

    log info "Created symlink: $display_target -> $display_link"
  fi

  return 0
}
