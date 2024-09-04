# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chief/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/chief/.fzf/bin"
fi

eval "$(fzf --bash)"
