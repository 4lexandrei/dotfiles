# Configs

export EDITOR=nvim
export TERM=xterm-256color

bind 'TAB:menu-complete'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

# Start of FZF configuration

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

FZF_PREVIEW_DIRS() {
  local dir="$1"

  if command -v eza &>/dev/null; then
    eza --tree --icons --color=always "$dir"
  else
    ls -al "$dir"
  fi
}

FZF_PREVIEW_FILES() {
  local file="$1"

  if command -v bat &>/dev/null; then
    bat -n --color=always "$file"
  else
    cat "$file"
  fi
}

FZF_PREVIEW_IMGS() {
  # NOTE: Install imagemagick package to preview all image formats
  local img="$1"
  kitty icat --clear --transfer-mode=memory --stdin=no --unicode-placeholder --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$img"
}

FZF_PREVIEW() {
  local item="$1"

  type=$(file -Lb --mime "$item")

  if [[ ! $type =~ image/ ]]; then
    if [[ -d "$item" ]]; then
      FZF_PREVIEW_DIRS "$item"
    else
      if [[ $type =~ binary ]]; then
        echo "No preview available"
      else
        FZF_PREVIEW_FILES "$item"
      fi
    fi
  else
    FZF_PREVIEW_IMGS "$item"
  fi
}

export -f FZF_PREVIEW_DIRS
export -f FZF_PREVIEW_FILES
export -f FZF_PREVIEW_IMGS
export -f FZF_PREVIEW

export FZF_DEFAULT_OPTS="
  --prompt 'Search: ' \
  --bind 'ctrl-d:reload(find . -type d)' \
  --bind 'ctrl-f:reload(find -type f)' \
  --layout=reverse --border --pointer='>' \
  --preview 'FZF_PREVIEW {}' \
  --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
"

# End of FZF configuration
