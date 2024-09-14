#!/bin/bash

DOTFILES_PATH="$(pwd)"

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
