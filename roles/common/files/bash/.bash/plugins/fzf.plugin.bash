if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
elif [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
fi

fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

if command -v bat > /dev/null; then
    cat='bat --color=always'
    less='bat --style=numbers --paging=always'
else
    cat='cat'
    less='less -f'
fi

export FZF_DEFAULT_OPTS="--height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) = ~binary ]] && echo {} is a binary file || $cat -n {} | head -100' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-p:execute($less -n {}),ctrl-v:execute(vim -n {}),ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
if command -v fdfind > /dev/null; then
    export FZF_DEFAULT_COMMAND="fdfind --type f --type l --follow --exclude .git"
    find=''
elif command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --type l --follow --exclude .git"
fi
