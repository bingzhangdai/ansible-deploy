alias sudo='sudo '
alias g++='g++ -g -std=c++11'
alias vi=vim

alias ccat='bat --style=plain,changes --color=always --paging=never'

if command -v fdfind > /dev/null; then
    alias fd='fdfind'
fi

alias proxy='http_proxy=http://127.0.0.1:1080 https_proxy=http://127.0.0.1:1080 '

alias rl='exec bash'