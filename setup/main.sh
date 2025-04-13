#!/bin/bash

DOTFILES_PATH="$(realpath "$(dirname "$0")/..")"

symlink() {
  local target="$1"
  local link="$2"

  target=$DOTFILES_PATH/$target
  link=$HOME/$link

  # Ensure target exists
  if [ ! -e "$target" ]; then
    echo "[ERROR] Target $target does not exists."
    return 1
  fi

  # Handle existing links or directories
  if [ -e "$link" ] || [ -L "$link" ]; then
    # Overwrite symlink
    rm -rf "$link"
    ln -snf "$target" "$link"
    echo -e "Overwritten $link:\n$target --> $link"
  else
    # Create the symlink
    ln -snf "$target" "$link"
    echo "Created symlink: $target -> $link"
  fi
}

# WARNING:
# symlink()
# Remember the second argument (link) gets permanently deleted, so specify correct a link
# to avoid deleting a different file or directory!

symlink_bashrc() {
  symlink ".bashrc" ".bashrc"
}

symlink_config() {
  # INFO: nvim directory is excluded in config_dirs
  local config_dirs
  config_dirs=$(find "$DOTFILES_PATH"/.config -maxdepth 1 -mindepth 1 -type d ! -name "nvim")

  if [ "$ALL_DOTFILES" = "true" ]; then
    for config_dir in $config_dirs; do
      symlink ".config/$(basename "$config_dir")" ".config/$(basename "$config_dir")"
    done
  else
    local selected_config_dirs
    selected_config_dirs=$(
      printf "%s\n" "$config_dirs" |
        fzf --multi --prompt "Select dotfiles to symlink: " \
          --header="Use <Tab> to select multiple entries and <Enter> to confirm" --border \
          --delimiter / --with-nth -1
    )

    for selected_config_dir in $selected_config_dirs; do
      if [ -n "$selected_config_dir" ]; then
        symlink ".config/$(basename "$selected_config_dir")" ".config/$(basename "$selected_config_dir")"
      fi
    done
  fi
}

symlink_local() {
  local local_bin_dir
  local_bin_dir="$DOTFILES_PATH/.local/bin"

  if [ ! -d "$HOME/.local/share/applications/" ]; then
    mkdir -p "$HOME/.local/share/applications/"
  fi
  if [ ! -d "$HOME/.local/share/fonts/" ]; then
    mkdir -p "$HOME/.local/share/fonts/"
  fi
  if [ ! -d "$HOME/.local/bin/" ]; then
    mkdir -p "$HOME/.local/bin/"
  fi

  symlink ".local/share/applications/firefox-private.desktop" ".local/share/applications/firefox-private.desktop"
  symlink ".local/share/fonts/JetBrainsMono" ".local/share/fonts/JetBrainsMono"

  for script in "$local_bin_dir"/*; do
    if [ -f "$script" ]; then
      symlink ".local/bin/$(basename "$script")" ".local/bin/$(basename "$script")"
    fi
  done
}

select_symlink() {
  local options
  options=$(find "$DOTFILES_PATH" -maxdepth 1 -mindepth 1 ! -name ".git*" -name ".*")
  options=(
    "${options[@]}"
    "All dotfiles"
  )

  local selection
  selection=$(
    # shellcheck disable=SC2016
    printf "%s\n" "${options[@]}" |
      fzf --prompt "Select dotfiles to symlink: " --border --delimiter / --with-nth -1 \
        --preview '
          if [[ {} == "All dotfiles" ]]; then
            echo -ne "This option will setup every dotfiles automatically except neovim dotfiles." |
              fold -s -w $FZF_PREVIEW_COLUMNS
          else
            FZF_PREVIEW {}
          fi
        '
  )

  case "$selection" in
  "$DOTFILES_PATH/.bashrc")
    symlink_bashrc
    ;;
  "$DOTFILES_PATH/.config")
    symlink_config
    ;;
  "$DOTFILES_PATH/.local")
    symlink_local
    ;;
  "All dotfiles")
    ALL_DOTFILES=true
    symlink_bashrc
    symlink_config
    symlink_local
    ;;
  *)
    echo "No option selected."
    ;;
  esac
}

select_symlink
