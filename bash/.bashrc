#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
alias ls='eza --icons --color=always'
alias grep='grep --color=auto'

parse_git_branch() {
  git branch --show-current 2>/dev/null | sed 's/\(.*\)/( \1)/'
}

# Colors
_RED=$(tput setaf 1)
_GREEN=$(tput setaf 2)
_ORANGE=$(tput setaf 3)
_BLUE=$(tput setaf 4)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)

# Default prompt
# PS1='[\u@\h \W]\$ '

PS1='${_GREEN}[${_RESET}\u@\h ${_BLUE}\W${_GREEN}]${_RED}$(parse_git_branch)${_RESET}$ '

# Define dirs for bashrc.d
BASHRC_D_DIR="$HOME/.dotfiles/bashrc.d"
SCRIPTS_DIR="$BASHRC_D_DIR/scripts"

# Load all files in the bashrc.d directory
if [[ -d "$BASHRC_D_DIR" ]]; then
  for file in "$BASHRC_D_DIR"/*.bashrc; do
    # shellcheck source=/dev/null
    [ -f "$file" ] && source "$file"
  done
fi

# Load all script files
if [[ -d "$SCRIPTS_DIR" ]]; then
  for file in "$SCRIPTS_DIR"/*.sh; do
    # shellcheck source=/dev/null
    [ -f "$file" ] && source "$file"
  done
fi
