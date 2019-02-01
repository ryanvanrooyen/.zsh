
# Disable command echo in Terminal
# stty -echoctl

# Mac Aliases
function trash() {
    mv -f "$1" ~/.Trash
}

# Set Virtual Environment variables
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Use normal CLI LS colors
# export CLICOLOR=1
# export CLICOLOR_FORCE=1
export LSCOLORS=AxFxCxDxcxgxgxhxhxhxhx

# iTerm2 Aliases
alias i_newtab="osascript -e 'tell application \"iTerm2\" to tell current window to create tab with default profile and split horizontally with same profile'"
# alias i_exec="osascript -e 'tell application \"iTerm2\" to tell current window to tell current session to write text \" $1 \"'"
alias i_exec="osascript -e 'tell application \"iTerm2\" to tell current window to tell current session to write text \" $1 \"'"

# General helpers
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

function alert() {
    osascript -e 'display notification "'$2'" with title "'$1'"'
}

