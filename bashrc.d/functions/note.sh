# Note

note() {
  # Notes

  # nvim + syncthing + obsidian

  # Opens Obsidian if not already running
  if pgrep -fl "obsidian" >/dev/null; then
    echo "Obsidian is already running"
  else
    echo "Starting Obsidian..."
    obsidian >/dev/null 2>&1 &
  fi

  local target_directory="$HOME"/Documents/Notes

  cd "$target_directory" || return

  if ! pgrep -x "syncthing" >/dev/null; then
    # Initialize syncthing in the background
    echo "Initializing syncthing..."
    syncthing -no-browser >/dev/null &
    disown

    # Add 10 seconds delay to allow Syncthing sync missing files
    for i in {10..1}; do
      echo -ne "\rWaiting for sync: $i seconds remaning"
      sleep 1
    done
    echo -e "\n Syncthing initialization complete. Files are ready for editing."

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

  # Navigate to folder if selected
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
