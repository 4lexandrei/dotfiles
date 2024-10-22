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
SCRIPTS_DIR="$BASHRC_D_DIR/scripts"

# Load all files in the bashrc.d directory
if [[ -d "$BASHRC_D_DIR" ]]; then
  for file in "$BASHRC_D_DIR"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi

# Load all function files
if [[ -d "$SCRIPTS_DIR" ]]; then
  for file in "$SCRIPTS_DIR"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi
