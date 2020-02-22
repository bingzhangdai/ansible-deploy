# z - jump around
# https://github.com/rupa/z

zsh_plugin="${_DOT_BASH_CACHE}/z.plugin.bash"

# download rupa/z if not exist
if [[ ! -e "$zsh_plugin" ]]; then
    echo "Downloading rupa/z ..."
    _download "https://raw.githubusercontent.com/rupa/z/master/z.sh" "$zsh_plugin"
    [[ $? -ne 0 ]] && return 1
fi

source $zsh_plugin

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}

unset zsh_plugin