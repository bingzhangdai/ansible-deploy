if _is_in_wsl; then
    # ignore treating *.dll files as executable under WSL
    export EXECIGNORE=*.dll
fi