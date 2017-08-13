
# Disable command echo in Terminal
stty -echoctl

# Set path for Go projects
export GOPATH=~/Documents/GoProjects
export PATH=$PATH:$GOPATH/bin

# Use normal CLI LS colors
# export CLICOLOR=1
# export CLICOLOR_FORCE=1
export LSCOLORS=AxFxCxDxcxgxgxhxhxhxhx

# iTerm2 Aliases
alias i_newtab="osascript -e 'tell application \"iTerm2\" to tell current window to create tab with default profile and split horizontally with same profile'"
# alias i_exec="osascript -e 'tell application \"iTerm2\" to tell current window to tell current session to write text \" $1 \"'"
alias i_exec="osascript -e 'tell application \"iTerm2\" to tell current window to tell current session to write text \" $1 \"'"

# General helpers
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
