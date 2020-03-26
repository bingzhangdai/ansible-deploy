function sshadd() {
    [[ $# -ne 3 ]] && util_log_error "add_ssh host user hostname" && return 1
    [[ ! -d ~/.ssh ]] && mkdir -m 700 ~/.ssh
    [[ ! -e ~/.ssh/config ]] && touch ~/.ssh/config && chmod 600 ~/.ssh/config
    echo -en "\n\nHost $1\n  User $2\n  HostName $3\n  ServerAliveInterval 30\n  ServerAliveCountMax 120" >> ~/.ssh/config
}

function sshlist() {
    [[ ! -e ~/.ssh/config ]] && return
    awk -v color=$DARK_GRAY -v none=$NONE '
        BEGIN{ print color "Host User HostName" none }
        $1 == "Host" {
            host = $2;
            next;
        }
        $1 == "User" {
            user = $2;
            next;
        }
        $1 == "HostName" {
            hostname = $2
            next;
        }
        host != "" && user != "" && hostname != ""{
            printf "%s %s %s\n", host, user, hostname;
            host = "";
            user = ""
            hostname = ""
        }
    ' ~/.ssh/config | column -t
}