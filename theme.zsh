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

function setGitColor {
    git branch >/dev/null 2>/dev/null && echo "%{$fg[white]%}" && return
    echo "%{$fg_bold[black]%}"
}

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$(setGitColor)$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ''`basename $VIRTUAL_ENV`': '
}

PS1=$'\n$GRAY$(virtualenv_info)$DARK_GREEN$(collapse_pwd)%{$reset_color%} $(git_prompt_info)
$WHITE$PROMPT_CHAR%{$reset_color%} '

# Git theming
ZSH_THEME_GIT_PROMPT_PREFIX="$WHITE("
ZSH_THEME_GIT_PROMPT_SUFFIX="$WHITE) %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="${BLUE}*$RESET"

git_prompt_status() {
    INDEX=$(git status --porcelain 2> /dev/null)
    STATUS=""

    Ahead="$(git status --porcelain -b | grep -E 'ahead' | sed 's/^.*ahead \([0-9][0-9]*\).*$/\1/')"
    Behind="$(git status --porcelain -b | grep -E 'behind' | sed 's/^.*behind \([0-9][0-9]*\).*$/\1/')"
    # Show the branch's ahead/behind status
    if [ ! -z "$Ahead" ]; then
	STATUS=" $Ahead${GREEN}↑$RESET$STATUS"
    fi
    if [ ! -z "$Behind" ]; then
	STATUS=" $Behind${RED}↓$RESET$STATUS"
    fi

    if [[ -z $(git status --porcelain) ]]
    then
	STATUS="$STATUS"
    else
	STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
    fi

    echo $STATUS
}
