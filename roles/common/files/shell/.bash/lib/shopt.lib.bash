# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd

# correct spelling errors during tab-completion
shopt -s dirspell

# autocorrect typos in path names when using `cd`
shopt -s cdspell;

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
# shopt -s cdable_vars
