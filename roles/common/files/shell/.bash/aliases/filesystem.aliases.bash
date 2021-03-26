# short and human-readable directory listing
alias dud='du -d 1 -h | sort -h'

# short and human-readable file listing
alias duf='du -sh * | sort -h | while read -r size file; do printf "${size}\t"; [[ -d "$file" ]] && printf "./${file}/\n" || printf -- "${file}\n"; done'

if command -v fdfind > /dev/null; then
    alias fd='fdfind'
fi

# quickly search for file
function _qfind() {
    while [ $# -gt 0 ]; do
        # printf -- '%s\n' "${RED}${1}${NONE}:"
        if command -v fd > /dev/null; then
            fd --type f ${FD_OPTIONS} --glob "$1" .
        else
            find . -type d \( -name .git \) -prune -false -o -iname "$1"
        fi
        shift
    done
    set +o noglob
}

function _rfind() {
    while [ $# -gt 0 ]; do
        # printf -- '%s\n' "${RED}${1}${NONE}:"
        if command -v fd > /dev/null; then
            fd --type f ${FD_OPTIONS} "$1" .
        else
            find . -type d \( -name .git \) -prune -false -o -iregex "$1"
        fi
        shift
    done
    set +o noglob
}

# temporarily stop shell wildcard character expansion
# re-enable expansion in _qfind function
alias qfind='set -o noglob; _qfind'
# regex find
alias rfind='set -o noglob; _rfind'