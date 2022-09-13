export CDPATH=".:/$HOME/.dirmark"

function mark()
{
  if [ ! -d "$HOME/.dirmark" ]; then
    mkdir -p $HOME/.dirmark
  fi

  if [ -z "$1" ]
  then
    echo "mark @bookmarkName"
  fi

  if [ ! -L "$HOME/.dirmark/$1" ]; then
    ln -s "$(pwd)" "$HOME/.dirmark/$1"
    echo "Bookmark added $1" 
  else 
    echo "Bookmark already exits"
  fi
}

function dmark(){
  if [ -L "$HOME/.dirmark/$1" ]; then 
    unlink "$HOME/.dirmark/$1"
    echo "Bookmark deleted"
  else
    echo "Bookmark not found"
  fi

}

function lmark(){
  local select_mark=$(ls -lAQ "$HOME/.dirmark/" |grep -Eo '".*"' | fzf -e --no-sort +m --query "$LBUFFER" --header="ctrl-v:paste,ctrl-d:delete"  --expect="ctrl-v,ctrl-d" --ansi --prompt="bookmark > ")
  if [ -n "$select_mark" ]; then
    local key=$(head -1 <<< "$select_mark")
    if [[ $key == 'ctrl-v' ]]; then
      BUFFER="$( echo -n ${select_mark} |tail -n 1 | awk '{print $3}')"
    elif [[ $key == 'ctrl-d' ]]; then
      dmark "$( echo -n ${select_mark} |tail -n 1 | awk '{print $1}' | sed 's|\"||g')"
      zle accept-line
    else
      cmd="cd $( echo -n ${select_mark}| tail -n 1 | awk '{print $3}')"
      eval $cmd
      zle accept-line
    fi
  fi
}

zle -N lmark
bindkey "^g" lmark

