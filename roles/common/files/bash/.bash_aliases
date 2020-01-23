alias sudo='sudo '
alias g++='g++ -g -std=c++11'
alias vi=vim

if command -v bat > /dev/null; then
    alias cat='bat --style=plain,changes --color=always --paging=never'
fi
