# https://pip.pypa.io/en/stable/user_guide/#command-completion

function _setup_pip_completion() {
    local -r _pip_completion="${_DOT_BASH_CACHE}/pip.completion.bash"
    
    if [ -e "$_pip_completion" ]; then
        source "$_pip_completion"
        return
    fi

    local _pip
    if command -v pip3 > /dev/null; then
        _pip=pip3
    elif command -v pip > /dev/null; then
        _pip=pip
    else
        return
    fi

    "$_pip" completion --bash > "$_pip_completion" 2> /dev/null

    [ $? -eq 0 ] && source "$_pip_completion"
}

_setup_pip_completion

unset -f _setup_pip_completion
