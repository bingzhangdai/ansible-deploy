# bash/zsh completion support for core Git.

git_plugin="${_DOT_BASH_CACHE}/git.completion.bash"

# download rupa/z if not exist
if [[ ! -e "$git_plugin" ]]; then
    util_log_info "Downloading git-completion.bash ..."
    util_download "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" "$git_plugin"
    [[ $? -ne 0 ]] && util_log_error "Download git-completion.bash failed" && return 1
    util_log_sucess "Download git-completion.bash succeeded"
fi

source $git_plugin

unset git_plugin
