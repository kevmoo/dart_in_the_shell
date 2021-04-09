#
# Installation:
#
# Via shell config file  ~/.bashrc  (or ~/.zshrc)
#
#   Append the contents to config file
#   'source' the file in the config file
#
# You may also have a directory on your system that is configured
#    for completion files, such as:
#
#    /usr/local/etc/bash_completion.d/
#

###-begin-whatsup.dart-completion-###

if type complete &>/dev/null; then
  __whatsup_dart_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           whatsup.dart completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __whatsup_dart_completion whatsup.dart
elif type compdef &>/dev/null; then
  __whatsup_dart_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 whatsup.dart completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __whatsup_dart_completion whatsup.dart
elif type compctl &>/dev/null; then
  __whatsup_dart_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       whatsup.dart completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __whatsup_dart_completion whatsup.dart
fi

###-end-whatsup.dart-completion-###

## Generated 2013-12-05 17:43:02.158Z
## By /Users/kevin/source/github/bot_io.dart/bin/shell-completion-generator

