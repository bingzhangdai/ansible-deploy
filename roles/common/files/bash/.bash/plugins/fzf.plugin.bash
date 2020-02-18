function setup_using_package() {
    (command -v dpkg > /dev/null && dpkg -s fzf &> /dev/null) || return 1

    # Auto-completion
    local completions="/usr/share/bash-completion/completions/fzf"
    [[ $- == *i* ]] && source $completions 2> /dev/null

    # Key bindings
    local key_bindings="/usr/share/doc/fzf/examples/key-bindings.bash"
    source $key_bindings
}

function setup_using_base_dir() {
    if [ -f ~/.fzf.bash ]; then
        source ~/.fzf.bash
    elif [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
    else
        return 1
    fi
}

setup_using_package || setup_using_base_dir || return 1


command -v fdfind > /dev/null && alias fd=fdfind && fd=fdfind

if command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND="${fd:-fd} --type f --type l --follow --hidden --exclude .git"
    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

fcd() {
    if command -v fd > /dev/null; then
        local dir=$(fd ${1:-.} --type d --hidden --follow --exclude .git 2> /dev/null | fzf +m)
    else
        local dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
    fi
    ex=$?
    [[ "$ex" -ne 0 ]] && return $ex
    cd "$dir"
}

unset fd

alias fvi='vi `fzf`'

if command -v bat > /dev/null; then
    cat='bat --color=always'
    less='bat --style=numbers --paging=always'
else
    cat='cat'
    less='less -f'
fi

export FZF_DEFAULT_OPTS="--height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) = ~binary ]] && echo {} is a binary file || $cat -n {} | head -100' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-p:execute($less -n {}),ctrl-v:execute(vim -n {}),ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"

unset cat less
