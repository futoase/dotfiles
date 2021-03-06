function fzf_key_bindings
  function __fzf_select
    command find * -path '*/\.*' -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print 2> /dev/null | fzf -m | while read item
      echo -n (echo -n "$item" | sed 's/ /\\\\ /g')' '
    end
    echo
  end

  function __fzf_ctrl_t
    if [ -n "$TMUX_PANE" -a "$FZF_TMUX" != "0" ]
      tmux split-window (__fzf_tmux_height) "fish -c 'fzf_key_bindings; __fzf_ctrl_t_tmux \\$TMUX_PANE'"
    else
      __fzf_select > $TMPDIR/fzf.result
      and commandline -i (cat $TMPDIR/fzf.result)
      rm -f $TMPDIR/fzf.result
    end
  end

  function __fzf_ctrl_t_tmux
    __fzf_select > $TMPDIR/fzf.result
    and tmux send-keys -t $argv[1] (cat $TMPDIR/fzf.result)
    rm -f $TMPDIR/fzf.result
  end

  function __fzf_ctrl_r
    if history | fzf +s +m > $TMPDIR/fzf.result
      commandline (cat $TMPDIR/fzf.result)
    else
      commandline -f repaint
    end
    rm -f $TMPDIR/fzf.result
  end

  function __fzf_alt_c
    command find * -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m > $TMPDIR/fzf.result
    if [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
      cd (cat $TMPDIR/fzf.result)
    end
    commandline -f repaint
    rm -f $TMPDIR/fzf.result
  end

  function __fzf_tmux_height
    if set -q FZF_TMUX_HEIGHT
      set height $FZF_TMUX_HEIGHT
    else
      set height 40%
    end
    if echo $height | grep -q -E '%$'
      echo "-p "(echo $height | sed 's/%$//')
    else
      echo "-l $height"
    end
    set -e height
  end

  bind \ct '__fzf_ctrl_t'
  bind \cr '__fzf_ctrl_r'
  bind \ec '__fzf_alt_c'
end
