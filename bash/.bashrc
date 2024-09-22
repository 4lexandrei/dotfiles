#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim

editfile() {
  file=$(fzf \
    --reverse \
    --pointer ">" \
    --preview "bat --color=always {}" \
    --margin=1 \
    --border)

  [ -n "$file" ] && $EDITOR "$file"
}

# Custom alias
alias ef='editfile'
alias cdf='cd $(find -type d | fzf)'
alias zedf='zeditor $(find -type d | fzf)'

alias bb='bashbuddy'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"

export TERM=xterm-256color
