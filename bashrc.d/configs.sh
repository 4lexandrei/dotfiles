# Configs

export EDITOR=nvim
export TERM=xterm-256color

export FZF_DEFAULT_OPTS="
  --bind 'ctrl-j:down,ctrl-k:up' \
  --bind 'alt-j:preview-down,alt-k:preview-up' \
  --prompt 'Search: ' \
  --layout=reverse --border --pointer='>' \
  --preview 'bat --color=always {}' \
  # morhetz/gruvbox
  --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
"

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"
