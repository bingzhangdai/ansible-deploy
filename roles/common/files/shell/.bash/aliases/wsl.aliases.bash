if [[ -n "$(_get_wsl_version)" ]]; then
    function git() {
        if /usr/bin/git config --get remote.origin.url | \grep -q 'visualstudio\|azure'; then
            if [[ "$1" == "update" ]]; then
                git.exe fetch --all --prune
            elif [[ "$1" =~ ^(purge)$ ]]; then
                /usr/bin/git "$@"
            else
                git.exe "$@"
            fi
        else
            /usr/bin/git "$@"
        fi
    }

    alias cmd='cmd.exe'
fi