# don't put duplicate lines or lines starting with space in the history.
# eliminate duplicates across the whole history
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# HISTTIMEFORMAT='%F %T '

# Ignore these commands
[[ -z "$HISTIGNORE" ]] && HISTIGNORE="ls:j:pwd"

# append to the history file, don't overwrite it
shopt -s histappend

# save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist
shopt -u lithist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
[[ -z "$HISTSIZE" ]] && HISTSIZE=100000
[[ -z "$HISTFILESIZE" ]] && HISTFILESIZE=200000

# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# store history immediately
# PROMPT_COMMAND="$PROMPT_COMMAND (history -a);"

function rh {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}