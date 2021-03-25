export _DOT_BASH_CACHE="$(cd $(dirname $BASH_SOURCE[0])/../ && pwd)/cache"

util_log_info() {
    printf -- "$@\n"
}

util_log_sucess() {
    printf -- "${GREEN}$@${NONE}\n"
}

util_log_warn() {
    printf -- "${YELLOW}$@${NONE}\n" > /dev/stderr
}

util_log_error() {
    printf -- "${RED}$@${NONE}\n" > /dev/stderr
}

util_download() {
    local URL="$1"
    local DEST="${2}"
    if [[ -z "$2" ]]; then
        # $2 empty
        DEST="${URL##*/}"
    elif [[ -d "$2" ]] || [[ -z "${2##*/}" ]]; then
        # $2 is dir
        DEST="${2}/${URL##*/}"
    fi

    local DIR="${DEST%${DEST##*/}}"
    # local DIR="$(dirname -- ${DEST})"
    if [[ -n "$DIR" ]] && [[ ! -d "$DIR" ]]; then
        mkdir "$DIR"
    fi

    if command -v curl > /dev/null; then
        curl -L "$URL" -o "$DEST"
    elif command -v wget > /dev/null; then
        wget "$URL" -O "$DEST"
    else
        util_log_error "ERROR: Please install curl or wget before downloading!"
        return 127
    fi
    local ex=$?
    if [[ $ex -ne 0 ]]; then
        util_log_error "ERROR: downloading ${URL##*/} failed!"
        return $ex
    fi
}

function _get_wsl_version() {
    local version="$(cat /proc/version)"
    if echo "$version" | grep -iqF microsoft; then
        echo "$version" | grep -iqF wsl2 && printf 2 || printf 1
    fi
}

function _is_in_wsl() {
    # $WSL_DISTRO_NAME is available since WSL builds 18362, also for WSL2
    [[ -n "$WSL_DISTRO_NAME" ]] && return
    [[ -n "$(uname -r | sed -E 's/^[0-9.]+-([0-9]+)-Microsoft.*|.*/\1/')" ]] && return
    [[ -n "$(_get_wsl_version)" ]]
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
fi