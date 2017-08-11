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
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%} ➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%} ═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%} ✭%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="$WHITE("
ZSH_THEME_GIT_PROMPT_SUFFIX="$WHITE) %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${GRAY}?$RESET"
ZSH_THEME_GIT_PROMPT_ADDED="${GREEN}+$RESET"
ZSH_THEME_GIT_PROMPT_MODIFIED="${BLUE}*$RESET"
ZSH_THEME_GIT_PROMPT_RENAMED="${BLUE}~$RESET"
ZSH_THEME_GIT_PROMPT_DELETED="${RED}x$RESET"
ZSH_THEME_GIT_PROMPT_UNMERGED="${YELLOW}!$RESET"

git_prompt_status() {
	INDEX=$(git status --porcelain 2> /dev/null)
	STATUS=""
	AddOrDelete=false
	OtherChanges=false

	Ahead="$(git status --porcelain -b | grep -E 'ahead' | sed 's/^.*ahead \([0-9][0-9]*\).*$/\1/')"
	Behind="$(git status --porcelain -b | grep -E 'behind' | sed 's/^.*behind \([0-9][0-9]*\).*$/\1/')"

	# Show the branch's ahead/behind status
	if [ ! -z "$Ahead" ]; then
		STATUS=" $Ahead${GREEN}↑$RESET$STATUS"
	fi
	if [ ! -z "$Behind" ]; then
		STATUS=" $Behind${RED}↓$RESET$STATUS"
	fi

	if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"; AddOrDelete=true
	elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"; AddOrDelete=true
	elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"; AddOrDelete=true
	fi

	if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"; OtherChanges=true
	fi

	if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"; OtherChanges=true
	fi

	if $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"; OtherChanges=true
	elif $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"; OtherChanges=true
	elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"; OtherChanges=true
	elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"; OtherChanges=true
	elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"; OtherChanges=true
	fi

	if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"; OtherChanges=true
	fi

	if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
		STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"; OtherChanges=true
	fi

	# If nothing has been modified, but there were adds/removals, add a space to keep the prompt clean.
	if [ "$OtherChanges" = false ] && [ "$AddOrDelete" = true ]; then
		STATUS=" $STATUS"
	fi

	echo $STATUS
}
