# ┌───────────┐
# │ ~/.bashrc │
# └───────────┘

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=500
export HISTFILESIZE=500

colored_prompt=true

if command -v eza &>/dev/null; then
  alias ls='eza --icons --color=always'
else
  alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'

# Colors
_BLACK="\[$(tput setaf 0)\]"
_RED="\[$(tput setaf 1)\]"
_GREEN="\[$(tput setaf 2)\]"
_ORANGE="\[$(tput setaf 3)\]"
_BLUE="\[$(tput setaf 4)\]"
_RESET="\[$(tput sgr0)\]"
_BOLD="\[$(tput bold)\]"
_BG_RED="\[$(tput setab 1)\]"
_BG_GREEN="\[$(tput setab 2)\]"
_BG_ORANGE="\[$(tput setab 3)\]"
_BG_BLUE="\[$(tput setab 4)\]"

# Default prompt
# PS1='[\u@\h \W]\$ '

git_ps1() {
  git branch --show-current 2>/dev/null | sed 's/\(.*\)/( \1)/'
}

if "$colored_prompt"; then
  # Colored
  # PS1='\[$_GREEN\][\[$_RESET\]\u@\h \[$_BLUE\]\W\[$_GREEN\]]\[$_RED\]$(git_ps1)\[$_RESET\]$ '
  # NOTE: if using double quotes embed commands with \
  PS1="${_GREEN}[${_RESET}\u@\h ${_BLUE}\W${_GREEN}]${_RED}\$(git_ps1)${_RESET} ✗ "
  # ✘ and ✗ are called Ballot x
else
  PS1='[\u@\h \W]$(git_ps1)$ '
fi

# Define dirs for bashrc.d
BASHRC_D_DIR="$HOME/.dotfiles/bashrc.d"

# Load all files in the bashrc.d directory
if [[ -d "$BASHRC_D_DIR" ]]; then
  for file in "$BASHRC_D_DIR"/*.sh; do
    # shellcheck source=/dev/null
    [ -f "$file" ] && source "$file"
  done
fi

export GTK_THEME=Adwaita:dark

# --- Development configurations ---
# Adds Rust to PATH
# shellcheck disable=SC1091
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# SDL
export SDL_VIDEODRIVER=wayland
