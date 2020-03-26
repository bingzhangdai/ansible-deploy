# z - jump around
# https://github.com/rupa/z

zsh_plugin="${_DOT_BASH_CACHE}/z.plugin.bash"

# download rupa/z if not exist
if [[ ! -e "$zsh_plugin" ]]; then
    util_log_info "Downloading rupa/z ..."
    util_download "https://raw.githubusercontent.com/rupa/z/master/z.sh" "$zsh_plugin"
    [[ $? -ne 0 ]] && util_log_error "Download rupa/z failed" && return 1
    util_log_sucess "Download rupa/z succeeded"
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