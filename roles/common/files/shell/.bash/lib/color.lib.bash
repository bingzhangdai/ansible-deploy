NONE=$'\033[00m'
DARK_GRAY=$'\033[1;30m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
ORANGE=$'\033[1;33m'
RED=$'\033[1;31m'
BLUE=$'\033[0;34m'
VIOLET=$'\033[1;35m'

if tput setaf 1 &> /dev/null; then
    YELLOW=$(tput setaf 136)
    ORANGE=$(tput setaf 166)
    VIOLET=$(tput setaf 61)
    BLUE=$(tput setaf 33)
    # GREEN=$(tput setaf 64);
    # RED=$(tput setaf 124);
fi