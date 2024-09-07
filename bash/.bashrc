#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nano

# Custom alias
alias editf='file=$(fzf \
--reverse \
--pointer ">" \
--preview "bat --color=always {}" \
--margin=1 \
--border);
[ -n "$file" ] && $EDITOR "$file"'
alias cdf='cd $(find -type d | fzf)'
alias zedf='zeditor $(find -type d | fzf)'

# Custom PATH
export PATH="$HOME/.local/bin:$PATH"
