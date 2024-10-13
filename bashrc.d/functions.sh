# Functions

note() {
  # nvim notes with syncthing

  local target_directory="$HOME"/Documents/Notes

  cd "$target_directory" || return

  if ! pgrep -x "syncthing" >/dev/null; then
    echo "Initializing syncthing..."
    syncthing -no-browser >/dev/null &
    disown # Starts syncthing in the background
  else
    echo "Syncthing is already running"
  fi

  sleep 0.5

  # Select subfolder
  folders=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' ! -name 'Excalidraw' | sed 's|^\./||')
  selected_folder=$(echo "$folders" | fzf --prompt="Please select: " --border --reverse)
  selected_folder=$(echo "$selected_folder" | xargs)

  # Navigate to folder if selected
  if [[ -n selected_folder ]]; then
    echo "Opening $selected_folder notes with $EDITOR"
    cd "$selected_folder"
  else
    echo "Opening notes with $EDITOR"
  fi

  $EDITOR .

  cd ~
}

notes() {
  # nvim notes with rclone (slower)

  provider="${1:-gdrive}" # gdrive as default argument

  # Check if the provider is already mounted
  if mount | grep ~/"$provider" >/dev/null; then
    echo "$provider is already mounted."
  else
    echo "Mounting $provider..."
    rclone mount "$provider": ~/"$provider" --vfs-cache-mode writes &

    # Wait until the provider is mounted
    until mount | grep ~/"$provider" >/dev/null; do
      sleep 0.5
    done
  fi

  cd ~/"$provider"/Notes || return

  # Select subfolder
  folders=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' ! -name 'Excalidraw' | sed 's|^\./||')
  selected_folder=$(echo "$folders" | fzf --prompt="Please select: " --border --reverse)
  selected_folder=$(echo "$selected_folder" | xargs)

  # Navigate to folder if selected
  if [[ -n selected_folder ]]; then
    echo "Opening $selected_folder notes with $EDITOR"
    cd "$selected_folder"
  else
    echo "Opening notes with $EDITOR"
  fi

  sleep 1
  $EDITOR .

  cd ~
}

editfile() {
  file=$(fzf \
    --reverse \
    --pointer ">" \
    --preview "bat --color=always {}" \
    --margin=1 \
    --border)

  [ -n "$file" ] && $EDITOR "$file"
}
