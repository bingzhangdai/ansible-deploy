# temporarily use proxy
alias proxy='http_proxy=http://127.0.0.1:1080 https_proxy=http://127.0.0.1:1080 '

# print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# reload bash
alias reload="exec ${SHELL} -l"
alias rl='reload'

# better top, glances is better than htop
# on wsl: https://github.com/nicolargo/glances/issues/1485
# pip3 install --upgrade glances
# pip3 install --upgrade psutil
if command -v glances > /dev/null; then
    alias top='glances'
elif command -v htop > /dev/null; then
    alias top='htop'
fi
