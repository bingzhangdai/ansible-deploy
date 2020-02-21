alias ..="cd .."
alias sudo='sudo '
alias g++='g++ -g -std=c++11'
alias vi=vim

alias ccat='bat --style=plain,changes --color=always --paging=never'

if command -v fdfind > /dev/null; then
    alias fd='fdfind'
fi

alias proxy='http_proxy=http://127.0.0.1:1080 https_proxy=http://127.0.0.1:1080 '

alias rl="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Prune local tracking branches that do not exist on remote anymore
alias git-remove-untracked="git branch -r | awk '{print \$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \$1}' | xargs -r git branch -d"