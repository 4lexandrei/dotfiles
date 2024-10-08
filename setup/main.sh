#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")/.."

# Create symlink, if not already
create_symlink() {
  local target="$1"
  local link="$2"

  if [ ! -L "$link" ]; then
    rm -rf "$link"
    ln -snf "$target" "$link"
    echo "Created symlink: $target -> $link"
  else
    echo "$link already a symlink"
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
  # konsole
  create_symlink "$DOTFILES_PATH"/konsole/transparent.profile "$HOME"/.local/share/konsole/transparent.profile

  # dekstop-entries
  create_symlink "$DOTFILES_PATH"/desktop-entries "$HOME"/.local/share/applications
}

symlinks
