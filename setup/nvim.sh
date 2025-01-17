#!/bin/bash

DOTFILES_PATH="$(realpath "$(dirname "$0")/..")"

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
    echo "Not found."
    exit 1
    ;;
  esac

  echo "Switched to $(basename "$selected_nvim_conf") configuration."
}

set_nvim_config
