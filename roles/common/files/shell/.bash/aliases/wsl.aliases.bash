if _is_in_wsl; then
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

    function _get_win_path() {
        if [[ $# -eq 0 ]]; then
            printf -- '.'
        else
            local _winpath="$(wslpath -w $* 2> /dev/null || echo $*)"
            printf -- '%s' "$_winpath"
        fi
    }

    # https://github.com/microsoft/WSL/issues/6565
    # explorer.exe always return 1 regardless the result
    function explorer() {
        local _winpath="$(_get_win_path $*)"
        powershell.exe start explorer.exe "$_winpath"
    }

    if command -v code > /dev/null; then
        function code() {
            local _winpath="$(_get_win_path $*)"
            cmd.exe /c code "$_winpath"
        }
    fi
fi