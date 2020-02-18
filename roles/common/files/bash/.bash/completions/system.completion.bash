# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    # some distribution makes use of a profile.d script to import completion.
    elif [ -f /etc/profile.d/bash_completion.sh ]; then
        . /etc/profile.d/bash_completion.sh
    fi
fi