# ┌───────────┐
# │ ~/.bashrc │
# └───────────┘

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=500
export HISTFILESIZE=1000

colored_prompt=true

if command -v eza &>/dev/null; then
  alias ls='eza --icons --color=always'
else
  alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'

# Colors
_BLACK='\[\033[30m\]'
_RED='\[\033[31m\]'
_GREEN='\[\033[32m\]'
_ORANGE='\[\033[33m\]'
_BLUE='\[\033[34m\]'
_RESET='\[\033[0m\]'
_BOLD='\[\033[1m\]'
_BG_RED='\[\033[41m\]'
_BG_GREEN='\[\033[42m\]'
_BG_ORANGE='\[\033[43m\]'
_BG_BLUE='\[\033[44m\]'

END_CHAR="✗" # ✘ and ✗ are called Ballot x✗

# Default prompt
# PS1='[\u@\h \W]\$ '

git_ps1() {
  git branch --show-current 2>/dev/null | sed 's/\(.*\)/( \1)/'
}

if "$colored_prompt"; then
  # Colored
  # NOTE: if using double quotes embed commands with \
  PS1="${_GREEN}[${_RESET}\u@\h ${_BLUE}\W${_GREEN}]${_RED}\$(git_ps1)${_RESET} \${END_CHAR} "
else
  PS1='[\u@\h \W]$(git_ps1) ${END_CHAR} '
fi

# Define bashrc.d directory
BASHRC_D_DIR="$HOME/.dotfiles/bashrc.d"

# Load all files in the bashrc.d directory
if [[ -d "$BASHRC_D_DIR" ]]; then
  for file in "$BASHRC_D_DIR"/*.sh; do
    # shellcheck source=/dev/null
    [ -f "$file" ] && source "$file"
  done
fi
