##  環境設定
autoload -Uz compinit
compinit
autoload -U colors; colors
autoload -Uz add-zsh-hook
autoload -Uz select-word-style
select-word-style default 
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|' # ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


##  オプション

bindkey -e

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

setopt no_beep
# setopt auto_cd
setopt CHASE_LINKS    # リンクへ移動するとき実体へ移動
setopt auto_param_keys
setopt auto_menu      # 複数の補完候補は一覧表示
setopt list_types     # 補完時にファイルの種別をマーク表示
setopt auto_list      # 補完候補は一覧表示
setopt list_packed    # 補完候補を詰めて表示
setopt extended_history
setopt share_history
setopt hist_reduce_blanks
# setopt notify
# setopt correct

#
##  エイリアス
#
local alias_path=$HOME/.dotfiles/zsh/alias.zsh
if [[ -e $alias_path ]] ; then
  source $alias_path
fi

#
##  自作メソッド
#
local my_method_path=$HOME/.dotfiles/zsh/my_zmethod.zsh
if [[ -e $my_method_path ]] ; then
  source $my_method_path
fi

#
##  zplug
#
export ZPLUG_HOME=$HOME/.dotfiles/zsh/plugins/.zplug
local zplug_init=$ZPLUG_HOME/init.zsh
local zplug_property=$HOME/.dotfiles/zsh
if [[ -e $zplug_init ]] ; then
  source $zplug_property/zplug_load.zsh
else
  echo; echo "$fg[red]not found zplug directory$reset_color"
fi

#
##  LEFT PROMPT
#
# local simple_prompt=$zsh_dir/zsh_simple_prompt
local prompt=$HOME/.dotfiles/zsh/left_prompt.zsh

if [ "$TERM" = linux ] ; then
  [ -e $simple_prompt ] && source $simple_prompt
else
  [ -e $prompt ] && source $prompt
fi

#
## RIGHT PROMPT
#
local rprompt=$HOME/.dotfiles/zsh/right_prompt.zsh
[ -e $rprompt ] && source $rprompt

#
## coloring on man command
#
export MANPAGER='less -R'
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
