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
    local cpwd=''
    [ "$PWD" != "$p" ] && cpwd+='~'
    [ "$p" = '/' ] && cpwd+='/'
    local IFS='/'
    for q in ${p:1}; do
        [ "${q:0:1}" = '.' ] && cpwd+="/${q:0:2}" || cpwd+="/${q:0:1}"
    done
    [ "${q:0:1}" = '.' ] &&  cpwd+="${q:2}" || cpwd+="${q:1}"
    printf '%s' "${1}${cpwd}${2}"
}

function _show_git() {
    (! command -v git > /dev/null) && return
    local _git_branch=$(git symbolic-ref -q --short HEAD 2> /dev/null)
    [[ -z "$_git_branch" ]] && return
    printf '%s' "[${1}${_git_branch}${2}]"
}

_exit_code=""
function _show_exit_code() {
    if [[ "$_exit_code" != "0" ]]; then
        printf '%s' ":${1}${_exit_code}${2}"
    fi
}

PROMPT_COMMAND="_exit_code=\$?;${PROMPT_COMMAND}"



NONE=$'\033[00m'
BOLD_GREEN=$'\033[01;32m'
BOLD_YELLOW=$'\033[01;33m'
BOLD_RED=$'\033[01;31m'
BOLD_DARK_GRAY=$'\033[1;30m'
# Special prompt variable: https://ss64.com/bash/syntax-prompt.html
if [ "$color_prompt" = yes ]; then
    PS1='\[${BOLD_GREEN}\]\u@\h\[${NONE}\]' # username@hostname
    PS1+=':$(_collapsed_pwd "\[${BOLD_YELLOW}\]" "\[${NONE}\]")' # :_collapsed_pwd
    PS1+='$(_show_git "\[${BOLD_DARK_GRAY}\]" "\[${NONE}\]")' # [_git_branch]
    PS1+='$(_show_exit_code "\[${BOLD_RED}\]" "\[${NONE}\]")' # :exit_code
    PS1+='\$ '
else
    PS1='\u@\h'
    PS1+=':$(_collapsed_pwd)'
    PS1+='$(_show_exit_code)'
    PS1+='\$ '
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