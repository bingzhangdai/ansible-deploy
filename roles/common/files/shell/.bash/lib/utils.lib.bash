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
    if [[ -n "$DIR" ]] && [[ ! -d "$DIR" ]]; then
        mkdir "$DIR"
    fi

    if command -v curl > /dev/null; then
        curl -L "$URL" -o "$DEST"
    elif command -v wget > /dev/null; then
        wget "$URL" -O "$DEST"
    else
        util_log_error "ERROR: Please install curl or wget before downloading!"
        return 1
    fi
    if [[ $? -ne 0 ]]; then
        util_log_error "ERROR: downloading ${URL##*/} failed!"
        return 1
    fi
}

function _get_wsl_version() {
    local version="$(cat /proc/version)"
    if echo "$version" | grep -iqF microsoft; then
        echo "$version" | grep -iqF wsl2 && printf 2 || printf 1
    fi
}
