#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Load all files in the bashrc.d directory
for file in ~/.dotfiles/bashrc.d/*.sh; do
  [ -f "$file" ] && . "$file"
done
