function add_ssh() {
    [[ $# -ne 3 ]] && echo "add_ssh host user hostname" && return 1
    [[ ! -d ~/.ssh ]] && mkdir -m 700 ~/.ssh
    [[ ! -e ~/.ssh/config ]] && touch ~/.ssh/config && chmod 600 ~/.ssh/config
    echo -en "\n\nHost $1\n  User $2\n  HostName $3\n  ServerAliveInterval 30\n  ServerAliveCountMax 120" >> ~/.ssh/config
}

function list_ssh() {
    awk '$1 ~ /Host$/ {for (i=2; i<=NF; i++) print $i}' ~/.ssh/config
}