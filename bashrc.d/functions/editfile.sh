# Editfile

editfile() {
  file=$(fzf \
    --prompt "Open with $EDITOR: " \
    --reverse \
    --pointer ">" \
    --preview "bat --color=always {}" \
    --margin=1 \
    --border)

  [ -n "$file" ] && $EDITOR "$file"
}
