# bash/zsh completion support for core Git.

p=$(cd `dirname $BASH_SOURCE[0]` && pwd)
git_plugin="${p}/cache/git.plugin.bash"

# download rupa/z if not exist
if [[ ! -e "$git" ]]; then
    echo "Downloading git-completion.bash ..."
    _download "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" "$git_plugin"
    [[ $? -ne 0 ]] && return 1
fi

source $git_plugin

unset p git_plugin
