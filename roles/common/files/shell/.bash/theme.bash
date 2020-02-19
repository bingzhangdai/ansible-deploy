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

_ex_code=""
function _set_ex_code() {
    local ex=$?
    if [ $ex -ne 0 ]; then
        _ex_code="$ex"
    else
        _ex_code=""
    fi
}

_git_branch=''
function _show_git() {
    (! command -v git > /dev/null) && return
    _git_branch=$(git symbolic-ref -q --short HEAD 2> /dev/null)
}

PROMPT_COMMAND="_set_ex_code;${PROMPT_COMMAND} _show_git;"

# Special prompt variable: https://ss64.com/bash/syntax-prompt.html
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]$(_collapsed_pwd)\[\033[00m\]$([ -n "$_git_branch" ] && printf "[")\[\033[1;30m\]$_git_branch\[\033[00m\]$([ -n "$_git_branch" ] && printf "]")$([ -z "$_ex_code" ] || printf :)\[\033[01;31m\]$_ex_code\[\033[00m\]\$ '
else
    PS1='\u@\h:$(_collapsed_pwd)$([ -z "$_ex_code" ] || printf :)$_ex_code\$ '
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