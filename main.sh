#!/bin/bash

DOTFILES_PATH="$(pwd)"

# Create symlinks
symlinks() {
  # bash
  ln -s "$DOTFILES_PATH/bash/.bashrc" "$HOME/"

  # konsole
  ln -s "$DOTFILES_PATH/konsole/transparent.profile" "$HOME/.local/share/konsole/"
  
  # nvim
  ln -s "$DOTFILES_PATH/nvim/init.lua" "$HOME/.config/nvim/"
  ln -s "$DOTFILES_PATH/nvim/lua/plugins/colorscheme.lua" "$HOME/.config/nvim/lua/plugins/"
}

symlinks
