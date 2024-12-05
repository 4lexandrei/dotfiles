#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")/.."

# Create symlink, if not already
create_symlink() {
  local target="$1"
  local link="$2"

  # Ensure target exists
  if [ ! -e "$target" ]; then
    echo "[ERROR] Target $target does not exists"
  fi

  confirmation_prompt() {
    if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
      echo "Aborted."
    else
      rm -rf "$link"
      ln -snf "$target" "$link"
      echo "Created symlink: $target -> $link"
    fi
  }

  # Check if link is a symlink
  if [ ! -L "$link" ]; then
    read -rp "Creating symlink: $target -> $link do you want to continue? [y/N]: " confirmation
    confirmation_prompt
  else
    read -rp "$link already a symlink. Do you want to overwrite it? [y/N]: " confirmation
    confirmation_prompt
  fi
}

# WARNING!
# create_symlink()
# Remember the second argument (link) gets deleted, so specify the config
# to avoid deleting the whole .config directory!

symlinks() {
  # hypr
  create_symlink "$DOTFILES_PATH"/hypr "$HOME"/.config/hypr

  # waybar
  create_symlink "$DOTFILES_PATH"/waybar "$HOME"/.config/waybar

  # rofi
  create_symlink "$DOTFILES_PATH"/rofi "$HOME"/.config/rofi

  # bash
  create_symlink "$DOTFILES_PATH"/bash/.bashrc "$HOME"/.bashrc

  # kitty
  create_symlink "$DOTFILES_PATH"/kitty "$HOME"/.config/kitty

  # tmux
  create_symlink "$DOTFILES_PATH"/tmux "$HOME"/.config/tmux

  # Others

  # dekstop-entries
  create_symlink "$DOTFILES_PATH"/desktop-entries "$HOME"/.local/share/applications
}

symlinks
