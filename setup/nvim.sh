#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")/.."

# SETUP_PATH="$DOTFILES_PATH/setup"

NVIM_CONFIG_PATH="$HOME/.config/nvim"

rm_nvim() {
  # Remove existing nvim symbolic link or directory
  echo "Removing current nvim configuration..."
  rm -rf "$NVIM_CONFIG_PATH"
  sleep 1
}

set_nvim() {
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

rm_nvim

set_nvim "$NVIM_CONFIG"
