# Note

note() {
  # Notes

  # nvim + syncthing + obsidian
  local target_directory="$HOME"/Documents/Notes
  local encoded_target_directory
  encoded_target_directory=$(printf "%s" "$target_directory" | sed "s/\//%2F/g; s/ /%20/g")

  # Opens Obsidian if not already running
  if pgrep -fla "electron" | grep -q "obsidian://open?path=$encoded_target_directory"; then
    echo "Obsidian is already running"
  else
    echo "Opening Obsidian on path: $target_directory..."
    nohup xdg-open "obsidian://open?path=$encoded_target_directory" >/dev/null 2>&1 &
    disown
  fi

  cd "$target_directory" || return

  if ! pgrep -x "syncthing" >/dev/null; then
    # Initialize syncthing in the background
    echo "Initializing syncthing..."
    syncthing -no-browser >/dev/null &
    disown

    echo "[TIP] Please check if devices are on the same WIFI SSID to ensure syncing."

    # Add 10 seconds delay to allow Syncthing sync missing files
    for i in {10..1}; do
      echo -ne "\rWaiting for sync: $i seconds remaning... "
      sleep 1
    done
    echo -e "\nSyncthing initialization complete. Files are ready for editing."

  else
    echo "Syncthing is already running"
  fi

  sleep 0.5

  # Select subfolder
  folders=$(find . -mindepth 1 -maxdepth 1 -type d \
    ! -name '.*' \
    ! -name 'Excalidraw' \
    ! -name 'Attachments' |
    sed 's|^\./||')
  selected_folder=$(echo "$folders" | fzf --prompt="Please select: " --border --reverse)
  selected_folder=$(echo "$selected_folder" | xargs)

  # Navigate to the selected folder
  if [[ -n "$selected_folder" ]]; then
    echo "Opening $selected_folder notes with $EDITOR"
    cd "$selected_folder" || return
  else
    echo "No folder selected, opening $target_directory with $EDITOR"
  fi

  # Open current directory with EDITOR
  $EDITOR .

  cd ~ || return
}
