# bash/zsh completion support for core Git.

git_plugin="${_DOT_BASH_CACHE}/git.completion.bash"

# download rupa/z if not exist
if [[ ! -e "$git_plugin" ]]; then
    echo "Downloading git-completion.bash ..."
    _download "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" "$git_plugin"
    [[ $? -ne 0 ]] && return 1
fi

source $git_plugin

unset git_plugin
