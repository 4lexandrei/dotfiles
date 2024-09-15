#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")"

# Create symlinks
symlinks() {
  # bash
  ln -s "$DOTFILES_PATH/bash/.bashrc" "$HOME/"

  # konsole
  ln -s "$DOTFILES_PATH/konsole/transparent.profile" "$HOME/.local/share/konsole/"

  # kitty
  ln -s "$DOTFILES_PATH/kitty/kitty.conf" "$HOME/.config/kitty/"
}

symlinks
