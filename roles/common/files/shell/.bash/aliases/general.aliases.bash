# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # colored less
    if test -e /usr/share/source-highlight/src-hilite-lesspipe.sh; then
        alias cless='LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s" less'
    elif command -v bat > /dev/null; then
        alias cless='LESSOPEN="| bat --style=plain --color=always --paging=never %s" less'
    fi

    # colored cat
    command -v batcat > /dev/null && alias bat=batcat
    command -v bat > /dev/null && alias cat='bat --style=plain --color=always --paging=never'

    # colored diff
    command -v icdiff > /dev/null && alias cdiff='icdiff --line-numbers'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ..='cd ..'
alias sudo='sudo '
alias xargs='xargs '
alias g++='g++ -g -std=c++17'
command -v vim > /dev/null && alias vi=vim
alias wget='wget -c'
alias mkdir='mkdir -pv'
alias du='du -h'
alias df='df -h'
alias cls='clear'
