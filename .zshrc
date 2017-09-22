
TERM=screen-256color

# Path configuration
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
# Activate antigen
source ~/.zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
 git
 zsh-users/zsh-history-substring-search
 zsh-users/zsh-autosuggestions
 zsh-users/zsh-syntax-highlighting
EOBUNDLES

source ~/.zshlocal

# export ZSH_AUTOSUGGEST_STRATEGY=default
export ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
antigen apply

# General Aliases
alias l='ls -alh'
alias cp='cp -iv'
alias mv='mv -iv'
alias path='echo -e ${PATH//:/\\n}'
alias svim='sudo vim -u ~/.vim/vimrc'

# Git Aliases
alias gs='git status -sb'
alias gb='git checkout -b $1'
alias ga='git add -A && git status -sb'
alias gr='git reset -q && git status -sb'Ï
alias gc='git commit -a -m '"$1"''
alias gpub='git push -uq origin `git rev-parse --abbrev-ref HEAD` && git status -sb'
alias gd='git diff --ignore-space-at-eol'
alias gdt='git difftool'
alias stash='git stash -q'
alias stashes='git --no-pager stash list'
alias pop='git stash pop -q && git status -sb'
alias switch='git stash -q && git checkout -q'
alias branches='git remote prune origin && git branch -a'
alias branch_cleanup='git remote prune origin && git branch -vv | grep '"'"': gone]'"'"' | awk '"'"'{print $1}'"'"' | xargs git branch -d'

if [[ `uname` == "Darwin" ]]; then
    source ~/.zsh/mac.zsh
elif [[ `uname` == "Linux" ]]; then
    source ~/.zsh/linux.zsh
fi

DISABLE_AUTO_TITLE="true"

#set up theme & omzsh stuff
COMPLETION_WAITING_DOTS="true"

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

# Set Virtual Environment variables
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Allows ctrl+s to register in Vim
stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

