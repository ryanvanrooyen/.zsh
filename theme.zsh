# Simple zsh theme to include virtual env info and git branch info in prompt.

# Color reference: https://github.com/yonchu/shell-color-pallet
GREEN="%{$fg[green]%}"
DARK_GREEN="%{$FG[028]%}"
WHITE="%{$fg[white]%}"
GRAY="%{$FG[242]%}"
RED="%{$FG[160]%}"
YELLOW="%{$FG[226]%}"
BLUE="%{$FG[038]%}"

RESET="%{$reset_color%}"
#PROMPT_CHAR=">>"

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ''`basename $VIRTUAL_ENV`': '
}

PS1=$'\n$GRAY$(virtualenv_info)$DARK_GREEN%~ $(git_prompt_info) $GRAY%(1j.[%j].)
$WHITE$PROMPT_CHAR '

# Git theming
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    Changes=$(git status --porcelain 2> /dev/null)
    BranchInfo=$(git status --porcelain -b 2> /dev/null)
    Status=""

    Ahead=$(echo $BranchInfo | grep -E 'ahead' | sed 's/^.*ahead \([0-9][0-9]*\).*$/\1/')
    Behind=$(echo $BranchInfo | grep -E 'behind' | sed 's/^.*behind \([0-9][0-9]*\).*$/\1/')

    # Show the branch's ahead/behind status
    if [ ! -z "$Ahead" ]; then
	Status=" $Ahead$GREEN↑$RESET$Status"
    fi
    if [ ! -z "$Behind" ]; then
	Status=" $Behind$RED↓$RESET$Status"
    fi

    if [ ! -z $Changes ]; then
	Status="$BLUE*$RESET$Status"
    fi

    echo "$WHITE(${ref#refs/heads/}$Status$WHITE)"
}

