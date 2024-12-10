#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")/.."

NVIM_CONFIG_PATH="$HOME/.config/nvim"

backup_nvim_config() {
  if [ -L "$NVIM_CONFIG_PATH" ] || [ -d "$NVIM_CONFIG_PATH" ]; then
    if [ -e "$NVIM_CONFIG_PATH.bak" ]; then
      # Ask the user if they want to overwrite the exisiting backup
      read -rp "A backup already exists ($NVIM_CONFIG_PATH.bak). Overwrite it? [y/N]: " confirmation
      if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        return 1
      else
        rm -rf "$NVIM_CONFIG_PATH.bak"
      fi
    fi
    echo "Backing up current nvim configuration..."
    mv "$NVIM_CONFIG_PATH" "$NVIM_CONFIG_PATH.bak"
    echo "$NVIM_CONFIG_PATH --> $NVIM_CONFIG_PATH.bak"
  else
    echo "No existing nvim configuration to backup"
  fi
  sleep 1
}

set_nvim_config() {
  # nvim
  case $1 in
  nvim)
    ln -snf "$DOTFILES_PATH/nvim/nvim" "$NVIM_CONFIG_PATH"
    ;;
  lazyvim)
    ln -snf "$DOTFILES_PATH/nvim/lazyvim" "$NVIM_CONFIG_PATH"
    ;;
  *)
    echo "Not found"
    exit 1
    ;;
  esac

  echo "Switched to $1 configuration."
}

echo -ne "Please select nvim configuration (nvim or lazyvim): "
read -r NVIM_CONFIG

backup_nvim_config

set_nvim_config "$NVIM_CONFIG"
