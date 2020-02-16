
p=$(cd `dirname $BASH_SOURCE[0]` && pwd)
source $p/z.sh

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}
