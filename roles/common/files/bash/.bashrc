# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

_ex_code=""
function _set_ex_code() {
    local ex=$?
    if [ $ex -ne 0 ]; then
        _ex_code="$ex"
    else
        _ex_code=""
    fi
}
PROMPT_COMMAND=_set_ex_code

function _collapsed_pwd() {
    local p="${PWD#$HOME}"
    [ "$PWD" != "$p" ] && printf '~'
    [ "$p" = '/' ] && printf '/'
    local IFS='/'
    for q in ${p:1}; do
        [ "${q:0:1}" = '.' ] && printf "/${q:0:2}" || printf "/${q:0:1}"
    done
    [ "${q:0:1}" = '.' ] &&  printf '%s' "${q:2}" || printf '%s' "${q:1}"
}

git_branch=''
git_color=''
function _show_git() {
    git_branch=$(git symbolic-ref -q --short HEAD 2> /dev/null)
    # local status=$(git status --porcelain -uno 2> /dev/null | tail -n1)
    if [[ -z "$(git status --porcelain 2> /dev/null | tail -n1)" ]]; then
        git_color=$'\033[01;32m'
    else
        git_color=$'\033[01;31m'
    fi
}
PROMPT_COMMAND="$PROMPT_COMMAND;_show_git"

# Special prompt variable: https://ss64.com/bash/syntax-prompt.html
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]$(_collapsed_pwd)\[\033[00m\]$([ -n "$git_branch" ] && printf "[")\[$git_color\]$git_branch\[\033[00m\]$([ -n "$git_branch" ] && printf "]")$([ -z "$_ex_code" ] || printf :)\[\033[01;31m\]$_ex_code\[\033[00m\]\$ '
else
    PS1='\u@\h:$(_collapsed_pwd)\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## colored man
# export PAGER="most"
# one scheme
# export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
# export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
# export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
# export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode    
# export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
# export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
# export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan
# another scheme
export LESS_TERMCAP_mb=$(printf '\e[01;33m') # enter blinking mode
export LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') # enter double-bright mode
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;31m') # enter standout mode
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;32;5;200m') # enter underline mode

## fd
FD_OPTIONS="--follow --exclude .git"

## fzf
if command -v bat > /dev/null; then
    cat='bat --color=always'
    less='bat --style=numbers --paging=always'
else
    cat='cat'
    less='less -f'
fi

export FZF_DEFAULT_OPTS="--height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) = ~binary ]] && echo {} is a binary file || $cat -n {} | head -100' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-p:execute($less -n {}),ctrl-v:execute(vim -n {}),ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
if command -v fdfind > /dev/null; then
    export FZF_DEFAULT_COMMAND="fdfind --type f --type l --follow --exclude .git"
    find=''
elif command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --type l --follow --exclude .git"
fi

## vi mode
set -o vi
