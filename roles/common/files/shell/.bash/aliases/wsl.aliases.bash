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

    # https://github.com/microsoft/WSL/issues/6565
    # explorer.exe always return 1 regardless the result
    function explorer() {
        if [[ $# -eq 0 ]]; then
            powershell.exe start explorer.exe .
        else
            local _winpath="$(wslpath -w $* 2> /dev/null || echo $*)"
            [[ -z "$_winpath" ]] && _winpath='.'
            powershell.exe start explorer.exe "$_winpath"
        fi
    }
fi