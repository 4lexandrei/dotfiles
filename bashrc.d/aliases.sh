# ┌─────────┐
# │ Aliases │
# └─────────┘

alias ll="ls -al"

alias tree="eza --tree"

alias sb="
  source ~/.bashrc && echo \".bashrc successfully sourced\" ||
  echo \"[ERROR] Couldn't source .bashrc\"
"

alias pp="preview-pictures"
alias sshot="screenshot"
alias mg="my-gits"

# Git
alias gs="git status"
alias gdt="git difftool"

# Tmux
alias ts="tmux-sessionizer"

# Ninja
alias ninja='ninja -j$(($(nproc) / 2))'

# function helpers
# NOTE: might get moved into a different file
pdf() {
  xdg-open "$1" &
  disown
}

mon() {
  top -p "$(pidof "$1")"
}
