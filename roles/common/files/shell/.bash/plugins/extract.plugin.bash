# https://github.com/Bash-it/bash-it/blob/master/plugins/available/extract.plugin.bash

# extract file(s) from compressed status
extract() {
    [ $# -eq 0 ] && extract -h && return 1
    while [ $# -gt 0 ]; do
        if [[ ! -f "$1" ]]; then
            echo "extract: '$1' is not a valid file" >&2
            shift
            continue
        fi

        # extract to tmp dir
        local tmp=$(mktemp -d -p $PWD)
        _exit=$?
        if [ "$_exit" -ne 0 ]; then
            echo "Could not create temp dir"
            exit "$_exit"
        fi

        local in_tmp=false

        if [ -f "$1" ]; then
           case "$1" in
                *.tar.bz2|*.tbz|*.tbz2) tar "xjf" "$1" -C "$tmp" > /dev/null && in_tmp=true ;;
                *.tar.gz|*.tgz) tar "xzf" "$1" -C "$tmp" > /dev/null && in_tmp=true ;;
                *.tar.xz|*.txz) tar "xJf" "$1" -C "$tmp" > /dev/null && in_tmp=true ;;
                *.tar.Z) tar "xZf" "$1" -C "$tmp" > /dev/null && in_tmp=true ;;
                *.bz2) bunzip2 -q "$1" ;;
                *.deb) dpkg-deb -x "$1" "${1:0:-4}" ;;
                *.pax.gz) gunzip "$1"; set -- "$@" "${1:0:-3}" ;;
                *.gz) gunzip "$1" ;;
                *.pax) pax -r -f "$1" ;;
                *.pkg) pkgutil --expand "$1" "${1:0:-4}" ;;
                *.rar) unrar x "$1" "$tmp" > /dev/null && in_tmp=true ;;
                *.rpm) rpm2cpio "$1" | cpio -idm ;;
                *.tar) tar "xf" "$1" -C "$tmp" > /dev/null && in_tmp=true ;;
                *.xz) xz --decompress "$1" ;;
                *.zip|*.war|*.jar|*.nupkg) unzip "$1" -d "$tmp" > /dev/null && in_tmp=true ;;
                *.Z) uncompress "$1" ;;
                *.7z) 7za x -o"$tmp" "$1" > /dev/null && in_tmp=true ;;
                *) echo "'$1' cannot be extracted via extract" >&2;;
            esac
        fi

        if "$in_tmp"; then
            local filename=$(basename -- $1)
            local filedirname=$(dirname -- $1)
            local targetdirname=$(sed 's/\(\.tar\.bz2$\|\.tar\.gz$\|\.tar\.xz$\|\.tar\.Z$\)//g' <<< $filename)
            if [ "$filename" == "$targetdirname" ]; then
                targetdirname="${1%.*}"
            fi

            if [ "$(\ls --almost-all -1 $tmp | wc -l)" = "1" ]; then
                local file=$(\ls $tmp)
                if [ -e "$file" ]; then
                    echo "$file already exists." >&2
                    rm -rf "$tmp"
                    shift
                    continue
                fi
                mv "$tmp"/* .
                rm -rf "$tmp"
                echo "extracted $([ -d $file ] && printf directory || printf file): '$file'"
            else
                if [ -e "$targetdirname" ]; then
                    echo "$targetdirname already exists." >&2
                    rm -rf "$tmp"
                    shift
                    continue
                fi
                mv "$tmp" "$targetdirname"
                echo "extracted files under '$targetdirname'"
            fi
        else
            rm -rf "$tmp"
        fi

        shift
    done
}
