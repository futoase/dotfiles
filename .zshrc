echo "loaded ~/.zshrc"

export LANG=ja_JP.UTF-8

autoload colors
colors

case ${UID} in
0)
  PROMPT="%B%n%b%# "
  PROMPT2="%B%n%b%# "
  SPROMPT="%B%r is correct? [n,y,a,e]:%b%# "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  RPROMPT="[%~]"
  SPROMPT="correct: %R -> %r ? "
  ;;
*)
  PROMPT="%n%# "
  PROMPT2="%n%# "
  SPROMPT="%r is correct? [n,y,a,e]:%# "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  RPROMPT="[%~]"
  SPROMPT="correct: %R -> %r ? "
  ;;
esac

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt nolistbeep
setopt nobeep

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

autoload -U compinit
compinit

setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -la"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias reload="source ~/.zshrc"

alias vi="mvim"
alias vim="mvim"

# ag
alias ag='ag -S --stats'
alias agh='ag --hidden'

unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

# local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# test
[ -f ~/.zshrc.test ] && source ~/.zshrc.test

