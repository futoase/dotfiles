set PATH $PATH $HOME/.nodebrew/current/bin
set PATH $PATH $HOME/bin $HOME/local/bin $HOME/Library/Haskell/bin
set PATH $PATH /usr/local/share/python /usr/local/share/python3
set PATH $PATH /usr/local/share/pypy /usr/local/Cellar/php54/5.4.16/bin
set PATH $PATH $HOME/local/packer /usr/local/opt/gnu-sed/libexec/gnubin

set GOPATH $GOPATH $HOME/go
set PATH $PATH $HOME/go/bin

set PATH $PATH $HOME/.rbenv/bin $HOME/.rbenv/shims 
rbenv rehash > /dev/null ^&1

function rbenv_shell
  set -l vers $argv[1]

  switch "$vers"
    case '--complete'
      echo '--unset'
      echo 'system'
      exec rbenv-versions --bare
      return
    case '--unset'
      set -e RBENV_VERSION
    case ''
      if [ -z "$RBENV_VERSION" ]
        echo "rbenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$RBENV_VERSION"
      end
    case '*'
      rbenv prefix "$vers" > /dev/null
      set -g -x RBENV_VERSION "$vers"
  end
end

function rbenv
  set -l command $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$command"
    case shell
      rbenv_shell $args
    case '*'
      command rbenv $command $args
  end
end

alias ll ls -la
alias vi mvim
alias vim mvim
