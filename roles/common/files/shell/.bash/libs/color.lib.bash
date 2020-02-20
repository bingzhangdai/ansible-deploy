NONE=$'\033[00m'
GREEN=$'\033[01;32m'
ORANGE=$'\033[01;33m'
RED=$'\033[01;31m'
DARK_GRAY=$'\033[1;30m'

if tput setaf 1 &> /dev/null; then
    ORANGE=$(tput setaf 166)
fi