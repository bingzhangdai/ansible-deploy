# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## fd
FD_OPTIONS="--follow --exclude .git"

## source scripts in .bash folder
# lib should sourced first. It contais predefined vars and funcs 
for path in ~/.bash/{lib,plugins,completions}; do
    for file in $(sort <(ls -1 $path/*.bash 2> /dev/null)); do
        [[ -e "$file" ]] && source $file || echo "Unable to read $file" > /dev/stderr
    done
done
unset path file
# theme
source ~/.bash/theme.bash