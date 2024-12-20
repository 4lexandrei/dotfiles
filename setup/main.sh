#!/bin/bash

DOTFILES_PATH="$(dirname "$(realpath "$0")")/.."

# Create symlink, if not already
create_symlink() {
  local target="$1"
  local link="$2"

  # Ensure target exists
  if [ ! -e "$target" ]; then
    echo "[ERROR] Target $target does not exists"
    return 1
  fi

  # Handle existing links or directories
  if [ -e "$link" ] || [ -L "$link" ]; then
    echo ""
    echo "$link already exists."

    # Proceed with overwriting prompt
    read -rp "Do you want to overwrite it? [y/N]: " overwrite_confirmation
    if [[ ! "$overwrite_confirmation" =~ ^[Yy]$ ]]; then
      echo "Skipped overwriting $link."
      return 1
    else
      # Backup prompts before overwriting
      backup "$link"

      # Overwrite symlink
      rm -rf "$link"
      ln -snf "$target" "$link"
      echo "Overwritten $link. $target --> $link"
    fi
  else
    # confirmation prompt before creating the symlink
    echo ""
    read -rp "Creating symlink: $target -> $link do you want to continue? [y/N]: " confirmation
    if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
      echo "Skipped creating symlink for $link".
      return 1
    else
      # Create the symlink
      ln -snf "$target" "$link"
      echo "Created symlink: $target -> $link"
    fi
  fi
}

backup() {
  local link="$1"

  read -rp "Do you want to create a backup of $link before overwriting? [y/N]: " backup_confirmation
  if [[ "$backup_confirmation" =~ ^[Yy]$ ]]; then
    if [ -e "${link}.bak" ]; then
      # If a backup already exists, ask whether to overwrite it
      read -rp "A backup already exists (${link}.bak). Overwrite it? [y/N]: " replace_backup_confirmation
      if [[ "$replace_backup_confirmation" =~ ^[Yy]$ ]]; then
        rm -rf "${link}.bak"
        echo "Replacing backup..."
      else
        echo "Skipping backup creation."
      fi
    fi

    # Create a backup if it doesn't already exist
    if [ ! -e "${link}.bak" ]; then
      mv "$link" "${link}.bak"
      echo "Backup created: $link --> ${link}.bak"
    fi
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

  # dekstop-entries
  create_symlink "$DOTFILES_PATH"/desktop-entries "$HOME"/.local/share/applications
}

symlinks
