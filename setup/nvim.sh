#!/bin/bash
# nvim.sh
# Nvim configuration selector

set -o errexit
set -o nounset
set -o pipefail

NVIM_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_PATH="$(realpath "$NVIM_SCRIPT_DIR/..")"

NVIM_CONFIG_PATH="$HOME/.config/nvim"

set_nvim_config() {
  nvim_dirs=$(find "$DOTFILES_PATH"/.config/nvim -maxdepth 1 -mindepth 1 -type d)

  local selected_nvim_conf
  selected_nvim_conf=$(
    printf "%s\n" "$nvim_dirs" |
      fzf --prompt "Select a neovim configuration: " --border \
        --delimiter / --with-nth -1
  )

  # nvim
  case $(basename "$selected_nvim_conf") in
  nvim)
    ln -snf "$DOTFILES_PATH/.config/nvim/nvim" "$NVIM_CONFIG_PATH"
    ;;
  lazyvim)
    ln -snf "$DOTFILES_PATH/.config/nvim/lazyvim" "$NVIM_CONFIG_PATH"
    ;;
  *)
    printf "Not found\n"
    exit 1
    ;;
  esac

  printf "Switched to %s configuration\n" "$(basename "$selected_nvim_conf")"
}

set_nvim_config
