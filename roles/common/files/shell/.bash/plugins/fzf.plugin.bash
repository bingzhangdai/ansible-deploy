function _setup_using_package() {
    # Auto-completion
    local completions="/usr/share/doc/fzf/examples/completion.bash"
    [[ $- == *i* ]] && source $completions 2> /dev/null || return

    # Key bindings
    local key_bindings="/usr/share/doc/fzf/examples/key-bindings.bash"
    source $key_bindings
}

function _setup_using_base_dir() {
    if [ -f ~/.fzf.bash ]; then
        source ~/.fzf.bash
    elif [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
    else
        false
    fi
}

_setup_using_package || _setup_using_base_dir || util_log_warn "Setup fzf failed"

command -v fdfind > /dev/null && alias fd=fdfind && fd=fdfind

if command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND="${fd:-fd} --type f --type l --follow --hidden --exclude .git"
    export FZF_ALT_C_COMMAND="${fd:-fd} --type d --type l --follow --hidden --exclude .git 2> /dev/null"
    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

function fcd() {
    if command -v fd > /dev/null; then
        local dir=$(fd . ${1:-.} --type d --hidden --follow --exclude .git 2> /dev/null | fzf +m)
    else
        local dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
    fi
    local ex=$?
    [[ "$ex" -ne 0 ]] && return $ex
    cd "$dir"
}

unset fd

function _set_fzf_default_opts() {
    if command -v bat > /dev/null; then
        local cat='bat --color=always'
        local less='bat --style=numbers --paging=always'
    else
        local cat='cat'
        local less='less -f'
    fi
    export FZF_DEFAULT_OPTS="--height 50% -1 --reverse --multi --inline-info --preview='([[ -d {} ]] && ls -Al --color=always {}) || ([[ \$(file --mime {}) =~ binary ]] && stat {}) || $cat -n {} | head -100' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-p:execute($less -n {}),ctrl-v:execute(vim -n {}),ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
}

_set_fzf_default_opts
