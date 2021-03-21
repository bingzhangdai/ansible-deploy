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

function _collapse() {
    local path="$*"
    local dir=''
    [[ "${path:0:1}" == '/' ]] && dir='/'
    local path="${path%%*(/)}"
    local base="${path##*/}"
    local d
    local IFS='/'
    for d in ${path%$base}; do
        [[ -z "$d" ]] && continue
        [[ "${d:0:1}" == '.' ]] && dir+="${d:0:2}/" || dir+="${d:0:1}/"
    done
    printf '%s' "${dir}${base}"
}

function _show_pwd() {
    # preserve exit status
    local exit=$?
    local path="${PWD#$HOME}"
    local prefix=''
    local format='%s'
    format="${1:-$format}"
    [[ "$path" != "$PWD" ]] && prefix='~'
    printf -- "$format" "$prefix$(_collapse "$path")"
    return $exit
}

# function _show_git() {
#     # preserve exit status
#     local exit=$?
#     local format='[%s]'
#     format="${1:-$format}"
#     (! command -v git > /dev/null) && return $exit
#     # "git symbolic-ref --short -q HEAD" is 40% faster than "git rev-parse --abbrev-ref HEAD"
#     local _git_branch=$(git symbolic-ref --short HEAD 2>&1)
#     [[ "$_git_branch" = *"fatal: not a git repository"* ]] && return $exit
#     [[ "$_git_branch" = *"fatal: ref HEAD is not a symbolic ref"* ]] && _git_branch=$(git rev-parse --short HEAD 2> /dev/null)
#     [[ -z "$_git_branch" ]] && return $exit
#     printf -- "$format" "$(_collapse ${_git_branch})"
#     return $exit
# }

# pure Bash version
function _show_git() {
    # preserve exit status
    local exit=$?
    local format='[%s]'
    format="${1:-$format}"
    local _git_branch=$(_get_git_branch)
    [[ -z "$_git_branch" ]] && return $exit
    printf -- "$format" "$(_collapse ${_git_branch})"
    return $exit
}

function _get_git_branch() {
    local _head_file _head
    local _dir="$PWD"

    while [[ -n "$_dir" ]]; do
        _head_file="$_dir/.git/HEAD"
        if [[ -f "$_dir/.git" ]]; then
            read -r _head_file < "$_dir/.git" && _head_file="$_dir/${_head_file#gitdir: }/HEAD"
        fi
        [[ -e "$_head_file" ]] && break
        _dir="${_dir%/*}"
    done

    if [[ -e "$_head_file" ]]; then
        read -r _head < "$_head_file" || return
        case "$_head" in
            ref:*) printf "${_head#ref: refs/heads/}" ;;
            "") ;;
            # HEAD detached
            *) printf "${_head:0:9}" ;;
        esac
        return 0
    fi

    return 128
}

# color can be found in lib/color.lib.bash
# Special prompt variable: https://ss64.com/bash/syntax-prompt.html

hostname='\h'
if _is_in_wsl; then
    if [[ -n "$WSL_DISTRO_NAME" ]]; then
        hostname="$WSL_DISTRO_NAME"
    else
        hostname="${NAME:-WSL}-$(_get_wsl_version)"
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [[ "$UID" == "0" ]]; then
        PS1="\[${ORANGE}\]\u@${hostname}\[${NONE}\]" # username@hostname
    else
        PS1="\[${GREEN}\]\u@${hostname}\[${NONE}\]"
    fi
    PS1+=':$(_show_pwd "\[${YELLOW}\]%s\[${NONE}\]")' # :_show_pwd
    PS1+='$(_show_git "[\[${DARK_GRAY}\]%s\[${NONE}\]]")' # [_git_branch]
    PS1+='$([[ "$?" == "0" ]] || printf "\[${RED}\]")\$\[${NONE}\] '
    PS2="\[${YELLOW}\]${PS2}\[${NONE}\]"
else
    PS1="\u@${hostname}"
    PS1+=':$(_show_pwd)'
    PS1+='$(exit=$?; [[ "$exit" == "0" ]] || printf ":$exit")'
    PS1+='\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;\u@${hostname}: \W\a\]$PS1"
    ;;
*)
    ;;
esac

unset hostname
