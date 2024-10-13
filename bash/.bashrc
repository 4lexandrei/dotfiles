#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim

editfile() {
  file=$(fzf \
    --reverse \
    --pointer ">" \
    --preview "bat --color=always {}" \
    --margin=1 \
    --border)

  [ -n "$file" ] && $EDITOR "$file"
}

note() {
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

# Custom configs
export FZF_DEFAULT_OPTS="
  --bind 'ctrl-j:down,ctrl-k:up' \
  --bind 'alt-j:preview-down,alt-k:preview-up' \
  --layout=reverse --border --pointer='>'
"

# Custom aliases
alias ef='editfile'
alias cdf='cd $(find -type d | fzf)'
alias zedf='zeditor $(find -type d | fzf)'

alias bb='bashbuddy'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

export TERM=xterm-256color
