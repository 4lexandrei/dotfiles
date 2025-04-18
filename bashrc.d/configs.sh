# ┌─────────┐
# │ Configs │
# └─────────┘

export EDITOR=nvim
export TERM=xterm-256color

bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

# ┌───────────────────┐
# │ BAT configuration │
# └───────────────────┘

if [[ -e "$HOME/.config/bat/themes/gruvbox-material.tmTheme" ]]; then
  export BAT_THEME="gruvbox-material"
fi

# ┌───────────────────┐
# │ FZF configuration │
# └───────────────────┘

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

export FZF_COMPLETION_TRIGGER='**'

export FZF_DEFAULT_OPTS="
  --prompt 'Search: ' \
  --bind 'ctrl-d:reload(find . -type d)' \
  --bind 'ctrl-f:reload(find -type f)' \
  --layout=reverse --border --pointer='>' \
  --preview '$HOME/.dotfiles/bashrc.d/scripts/fzf-preview.sh {}' \
  --color=bg+:#32302f,bg:#292828,spinner:#89b482,hl:#7daea3 --color=fg:#bdae93,header:#7daea3,info:#89b482,pointer:#7daea3 --color=marker:#89b482,fg+:#ebdbb2,prompt:#e78a4e,hl+:#7daea3
"
