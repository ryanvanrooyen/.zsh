
TERM=screen-256color

export PATH="/usr/local/bin:$PATH"

# Set default prompt character
PROMPT_CHAR='>'

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '~/.zsh/.zshrc'
autoload -Uz compinit
compinit

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.histfile
HISTSIZE=5000
SAVEHIST=1000
bindkey -v

# Set antigen install folder
ADOTDIR=~/.zsh/.antigen
source ~/.zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
 zsh-users/zsh-autosuggestions
 zsh-users/zsh-syntax-highlighting
EOBUNDLES

source ~/.zshlocal

export ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
antigen apply

# General Aliases
alias watch='watch -c -t -n 1 '
alias ts='sed -l '"'s/^/`date +'''%a %b %d %k:%M:%S:'''` /'"''
alias l='ls -Aoh'
alias cp='cp -iv'
alias mv='mv -iv'
alias path='echo -e ${PATH//:/\\n}'
alias svim='sudo vim -u ~/.vim/vimrc'
alias f='find ./ -name "$1"'

# Home Aliases
alias bblue='ssh bblue -qt "tmux a || (echo '"'creating new session...'"' && tmux)"'
alias home='ssh home -qt "tmux a || (echo '"'creating new session...'"' && tmux)"'

# Git Aliases
alias gs='git -c color.status=always status -sb'
function ga() { git add "$@" && git status -sb }
alias gg='git grep -n --break --heading'
alias gc='git commit -m '"$1"''
alias gco='git checkout'
alias gpub='git push -uq origin `git rev-parse --abbrev-ref HEAD` && git status -sb'
alias gd='git diff --color --ignore-space-at-eol'
alias gdt='git difftool'
alias branches='git remote prune origin && git branch -a'
alias gl='git log --color --graph --pretty=format:"%C(auto)%h %C(cyan)%cN (%cr)%C(auto)%d%n        %<(70,trunc)%s%n"'

if [[ `uname` == "Darwin" ]]; then
    source ~/.zsh/mac.zsh
elif [[ `uname` == "Linux" ]]; then
    source ~/.zsh/linux.zsh
fi

# DISABLE_AUTO_TITLE="true"

#set up theme & omzsh stuff
COMPLETION_WAITING_DOTS="true"

function tmx()
{
    file=${1:-all}
	source "$HOME/.tmux/$file.conf";
}

function extract() # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

source ~/.zsh/theme.zsh

# Allows ctrl+s to register in Vim
stty -ixon

[[ $TMUX = "" ]] && export TERM="xterm-256color"

alias ag='ag --hidden'
alias s='ag -Q -i -C 0 --hidden -p ~/.zsh/.agignore'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export CLICOLOR_FORCE=1

