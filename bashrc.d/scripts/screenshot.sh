# Screenshot

screenshot() {
  local save_dir="$HOME/Pictures/Screenshots"
  local new_save
  new_save="$save_dir/screenshot-$(date +%F_%T).png"

  # Create Screenshot dir if it doesn't exist
  mkdir -p "$save_dir"

  if [[ "$1" == "cut" || "$1" == "-c" ]]; then
    # Capture region with slurp
    grim -g "$(slurp)" "$new_save"
  else
    # Full-screen screenshot

    for i in {4..1}; do
      echo -ne "\rTaking fullscreen screenshot in $i seconds..."
      sleep 1
    done

    echo ""

    grim "$new_save"
  fi

  # Prompt for new filename after taking the screenshot
  echo -ne "Rename screenshot or press 'Enter' to keep default: "
  read -r screenshot_name

  if [[ -n "$screenshot_name" ]]; then
    local save_as="$save_dir/$screenshot_name.png"
    mv "$new_save" "$save_as"
    echo "Screenshot saved as $save_as"
  else
    echo "Screenshot saved as $new_save"
  fi

}

preview_pictures() {
  # Preview pictures in fzf with kitty icat
  local picture_dir="$HOME/Pictures"

  find "$picture_dir" -type f | fzf \
    --preview='kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {}'
}
