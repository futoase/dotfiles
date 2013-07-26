export MAKEOPTS="-j4"

source ~/perl5/perlbrew/etc/bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
eval "$(hub alias -s)"

fpath=(.zshdir/zsh-completions/src $fpath)
