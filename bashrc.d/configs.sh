# Configs

export EDITOR=nvim
export TERM=xterm-256color

bind 'TAB:menu-complete'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

# Start of FZF configuration

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

if command -v eza &>/dev/null; then
  FZF_PREVIEW_DIRS="eza --tree --icons --color=always {}"
else
  FZF_PREVIEW_DIRS="ls -al {}"
fi

if command -v bat &>/dev/null; then
  FZF_PREVIEW_FILES="bat -n --color=always {}"
else
  FZF_PREVIEW_FILES="cat {}"
fi

export FZF_DEFAULT_OPTS="
  --prompt 'Search: ' \
  --bind 'ctrl-d:reload(find . -type d),ctrl-f:reload(find -type f)' \
  --layout=reverse --border --pointer='>' \
  --preview '[[ -d {} ]] && ${FZF_PREVIEW_DIRS} || ${FZF_PREVIEW_FILES}' \
  # morhetz/gruvbox
  --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
"

# Preview file content using bat
export FZF_CTRL_T_OPTS="--preview '${FZF_PREVIEW_FILES}'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview '${FZF_PREVIEW_DIRS}'"

# End of FZF configuration
