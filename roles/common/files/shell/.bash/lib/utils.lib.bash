_eprintf() {
    printf "${RED}$@${NONE}" > /dev/stderr
}

_eecho() {
    echo "${RED}$@${NONE}" > /dev/stderr
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
        _eecho "ERROR: Please install curl or wget before downloading!"
        return 1
    fi
    if [[ $? -ne 0 ]]; then
        _eecho "ERROR: downloading ${URL##*/} failed!"
        return 1
    fi
}
