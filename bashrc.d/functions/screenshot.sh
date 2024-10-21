# Screenshot

screenshot() {
  local save_dir="$HOME/Pictures/Screenshots"
  local save_as
  save_as="$save_dir/screenshot-$(date +%F_%T).png"

  # Create Screenshot dir if it doesn't exist
  mkdir -p "$save_dir"

  if [[ "$1" == "cut" || "$1" == "-c" ]]; then
    # Capture region with slurp
    region=$(slurp)

    if [ -z "$region" ]; then
      echo "Screenshot canceled."
      return 1 # Exit if ESC is pressed
    fi

    grim -g "$region" "$save_as"
  else
    # Full-screen screenshot
    grim "$save_as"
  fi
}

preview_pictures() {
  # Preview pictures in fzf with kitty icat
  local picture_dir="$HOME/Pictures"

  find "$picture_dir" -type f | fzf \
    --preview='kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {}'
}
