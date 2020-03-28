# short and human-readable directory listing
alias dud='du -d 1 -h | sort -h'

# short and human-readable file listing
alias duf='du -sh * | sort -h | while read -r size file; do printf "${size}\t"; [[ -d "$file" ]] && printf "./${file}/\n" || printf -- "${file}\n"; done'

# quickly search for file
alias qfind="find . -name "