_eprintf() {
    printf "$@" > /dev/stderr
}

_echo() {
    echo "$@" > /dev/stderr
}

_download() {
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

    if [[ -x "$(which curl)" ]]; then
        curl -L "$URL" -o "$DEST"
    elif [[ -x "$(which wget)" ]]; then
        wget "$URL" -O "$DEST"
    else
        _echo "${RED}ERROR: Please install curl or wget before downloading! ${NONE}"
        return 1
    fi
    if [[ $? -ne 0 ]]; then
        _echo "${RED}ERROR: downloading ${URL##*/} failed! ${NONE}"
        return 1
    fi
}
