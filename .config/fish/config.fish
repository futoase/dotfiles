set PATH $PATH $HOME/.nodebrew/current/bin
set PATH $PATH $HOME/bin $HOME/local/bin $HOME/Library/Haskell/bin
set PATH $PATH /usr/local/share/pypy /usr/local/Cellar/php54/5.4.16/bin
set PATH $PATH $HOME/local/packer /usr/local/opt/gnu-sed/libexec/gnubin
set PATH $PATH $HOME/local/cocos2d-x-2.2.2/tools/project-creator
set PATH $PATH /usr/local/bin
set PATH $PATH $HOME/Library/Python/2.7/bin
set PATH $PATH $HOME/google-cloud-sdk/bin
set -x DOCKER_HOST 'tcp://localhost:4243'

set -x LC_ALL ja_JP.UTF-8

set -x EDITOR vim

set PATH $PATH $HOME/.plenv/bin
plenv rehash > /dev/null ^&1

set -x GOPATH $HOME/go
set PATH $PATH $HOME/go/bin

set PATH $PATH $HOME/.rbenv/bin $HOME/.rbenv/shims 
rbenv rehash > /dev/null ^&1

alias ll "ls -la"
alias vi mvim
alias vim mvim
