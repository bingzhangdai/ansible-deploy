NONE=$'\033[00m'
GREEN=$'\033[01;32m'
ORANGE=$'\033[01;33m'
RED=$'\033[01;31m'
DARK_GRAY=$'\033[1;30m'
VIOLET=$'\033[1;35m'
BLUE=$'\033[0;34m'

if tput setaf 1 &> /dev/null; then
    ORANGE=$(tput setaf 166)
    VIOLET=$(tput setaf 61)
    BLUE=$(tput setaf 33);
fi