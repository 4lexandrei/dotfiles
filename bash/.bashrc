#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Defind dirs for bashrc.d
BASHRC_D_DIR="$HOME/.dotfiles/bashrc.d"
FUNCTIONS_DIR="$BASHRC_D_DIR/functions"

# Load all files in the bashrc.d directory
if [[ -d "$BASHRC_D_DIR" ]]; then
  for file in "$BASHRC_D_DIR"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi

# Load all function files
if [[ -d "$FUNCTIONS_DIR" ]]; then
  for file in "$FUNCTIONS_DIR"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi
