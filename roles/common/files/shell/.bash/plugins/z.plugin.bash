# z - jump around
# https://github.com/rupa/z

p=$(cd `dirname $BASH_SOURCE[0]` && pwd)
zsh="${p}/z.sh"

# download rupa/z if not exist
if [[ ! -f "$zsh" ]]; then
    echo "Downloading rupa/z ..."
    URL="https://raw.githubusercontent.com/rupa/z/master/z.sh"
    if [[ -x "$(which curl)" ]]; then
        curl -L "$URL" -o "$zsh"
    elif [[ -x "$(which wget)" ]]; then
        wget "$URL" -O "$zsh"
    else
        echo "ERROR: please install curl or wget before downloading !!"
        return 1
    fi
    if [[ $? -ne 0 ]]; then
        echo "ERROR: downloading rupa/z failed !!"
        return 1
    fi
fi

source $p/z.sh

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}
