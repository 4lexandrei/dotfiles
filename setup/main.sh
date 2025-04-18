#!/bin/bash
# main.sh
# Main setup script to easily symlink dotfiles (neovim config excluded)

set -o errexit
set -o nounset
set -o pipefail

MAIN_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_PATH="$(realpath "$MAIN_SCRIPT_DIR/..")"

source "$MAIN_SCRIPT_DIR/lib/helpers.sh" || exit 1
source "$MAIN_SCRIPT_DIR/lib/symlink.sh" || exit 1

check_function "symlink"

# WARNING: symlink()
# this function validates link paths with validate_path()
# However, always double-check parameters to prevent unrecoverable actions

symlink_bashrc() {
  symlink ".bashrc" ".bashrc"
}

symlink_config() {
  # INFO: nvim directory is excluded in config_dirs
  local config_dirs
  config_dirs=$(find "$DOTFILES_PATH"/.config -maxdepth 1 -mindepth 1 -type d ! -name "nvim")

  if [[ "$ALL_DOTFILES" = "true" ]]; then
    for config_dir in $config_dirs; do
      symlink ".config/$(basename "$config_dir")" ".config/$(basename "$config_dir")"
    done
  else
    local selected_config_dirs
    selected_config_dirs=$(
      printf "%s\n" "$config_dirs" |
        fzf --multi --prompt "Select dotfiles to symlink: " \
          --header="Use <Tab> to select multiple entries and <Enter> to confirm" --border \
          --delimiter / --with-nth -1
    )

    for selected_config_dir in $selected_config_dirs; do
      if [[ -n "$selected_config_dir" ]]; then
        symlink ".config/$(basename "$selected_config_dir")" ".config/$(basename "$selected_config_dir")"
      fi
    done
  fi
}

symlink_local() {
  if [[ ! -d "$HOME/.local/share/applications/" ]]; then
    mkdir -p "$HOME/.local/share/applications/"
  fi
  if [[ ! -d "$HOME/.local/share/fonts/" ]]; then
    mkdir -p "$HOME/.local/share/fonts/"
  fi
  if [[ ! -d "$HOME/.local/bin/" ]]; then
    mkdir -p "$HOME/.local/bin/"
  fi

  symlink ".local/share/applications/firefox-private.desktop" ".local/share/applications/firefox-private.desktop"
  symlink ".local/share/fonts/JetBrainsMono" ".local/share/fonts/JetBrainsMono"

  for script in "$DOTFILES_PATH/.local/bin"/*; do
    if [[ -f "$script" ]]; then
      symlink ".local/bin/$(basename "$script")" ".local/bin/$(basename "$script")"
    fi
  done
}

symlink_all() {
  ALL_DOTFILES=true
  symlink_bashrc
  symlink_config
  symlink_local
}

select_symlink() {
  local options
  options=$(find "$DOTFILES_PATH" -maxdepth 1 -mindepth 1 ! -name ".git*" -name ".*")
  options=(
    "${options[@]}"
    "All dotfiles"
  )

  local selection
  selection=$(
    # shellcheck disable=SC2016
    printf "%s\n" "${options[@]}" |
      fzf --prompt "Select dotfiles to symlink: " --border --delimiter / --with-nth -1 \
        --preview '
          if [[ {} == "All dotfiles" ]]; then
            echo -ne "This option will setup every dotfiles automatically (except neovim dotfiles)" |
              fold -s -w $FZF_PREVIEW_COLUMNS
          else
            $HOME/.dotfiles/bashrc.d/scripts/fzf-preview.sh {}
          fi
        '
  )

  case "$selection" in
  "$DOTFILES_PATH/.bashrc")
    symlink_bashrc
    ;;
  "$DOTFILES_PATH/.config")
    symlink_config
    ;;
  "$DOTFILES_PATH/.local")
    symlink_local
    ;;
  "All dotfiles")
    symlink_all
    ;;
  *)
    printf "No option selected\n"
    ;;
  esac
}

select_symlink
