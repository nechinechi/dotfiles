# http://d.hatena.ne.jp/kei_q/20110308/1299594629
# http://qiita.com/items/1f2c7793944b1f6cc346
function _show-buffer-stack {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
  # zle reset-prompt
}
zle -N _show-buffer-stack
setopt noflowcontrol
bindkey '^Q' _show-buffer-stack

function _kill-backward-blank-word {
  # 現在位置から左のスペースまでをkillする
  zle set-mark-command
  zle vi-backward-blank-word
  zle kill-region
}
zle -N _kill-backward-blank-word
bindkey '^S' _kill-backward-blank-word

function _kill-first-word {
  zle beginning-of-line
  zle vi-forward-blank-word
  zle backward-char
  zle set-mark-command
  zle vi-backward-blank-word
  # zle kill-word
  # zle vi-forward-blank-word
  # zle vi-forward-blank-word-end
  # zle forward-char
  zle kill-region
}
zle -N _kill-first-word
bindkey '^V' _kill-first-word

function _cd-parent-directory {
  if [ -z $BUFFER ] ; then
    builtin cd ..
    zle accept-line
  fi
}
zle -N _cd-parent-directory
bindkey '^O' _cd-parent-directory

# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line
# bindkey "^V" quoted-insert

# bindkey "^K" kill-line
# bindkey "^U" kill-whole-line

function _forward-char-or-cdr {
  if [ -z $BUFFER ] ; then
    cdr
    zle accept-line
  else
    zle forward-char
  fi
}
zle -N _forward-char-or-cdr
bindkey '^F' _forward-char-or-cdr

function _backward-char-or-home {
  if [ -z $BUFFER ] ; then
    if [ $PWD != $HOME ] ; then
      builtin cd $HOME
      zle accept-line
    fi
  else
    zle backward-char
  fi
}
zle -N _backward-char-or-home
bindkey '^B' _backward-char-or-home


# function _kill-line- {
#   if [ -z $BUFFER ] ; then
#     # any command
#     zle accept-line
#   else
#     zle kill-line
#   fi
# }
# zle -N _kill-line-
# bindkey '^K' _kill-line-

# function _kill-whole-line- {
#   if [ -z $BUFFER ] ; then
#     # any command
#     zle accept-line
#   else
#     zle kill-whole-line
#   fi
# }
# zle -N _kill-whole-line-
# bindkey '^U' _kill-whole-line-


# function my_enter {
#   if [[ -n "$BUFFER" ]]; then
#     builtin zle .accept-line
#     return 0
#   fi
#   if [ "$WIDGET" != "$LASTWIDGET" ]; then
#     MY_ENTER_COUNT=0
#   fi
#   case $[MY_ENTER_COUNT++] in
#     0)
#       BUFFER=" ls"
#       ;;
#     1)
#       if [[ -d .svn ]]; then
#         BUFFER=" svn status"
#       elif git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#         BUFFER=" git status -sb"
#       fi
#       ;;
#     *)
#       unset MY_ENTER_COUNT
#       ;;
#   esac
#   builtin zle .accept-line
# }
# zle -N my_enter
# bindkey '^m' my_enter
