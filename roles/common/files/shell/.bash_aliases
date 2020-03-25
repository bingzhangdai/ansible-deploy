alias proxy='http_proxy=http://127.0.0.1:1080 https_proxy=http://127.0.0.1:1080 '

if test -e /usr/share/source-highlight/src-hilite-lesspipe.sh; then
    alias cless='LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s" less'
elif command -v bat > /dev/null; then
    alias ccat='bat --style=plain,changes --color=always --paging=never'
    alias cless='LESSOPEN="| bat --style=plain,changes --color=always --paging=never %s" less'
fi

alias rl="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias today='date +"%A, %B %-d, %Y"'

alias ports='lsof -i | grep LISTEN'

# Short and human-readable directory listing
alias dud='du -d 1 -h | sort -h'

# Short and human-readable file listing
alias duf='du -sh * | sort -h | while read -r size file; do printf "${size}\t"; [[ -d "$file" ]] && printf "./${file}/\n" || printf "${file}\n"; done'
