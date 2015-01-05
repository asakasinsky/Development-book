# FUNCTIONS
# =================================

# Use: mkpasswd <length>
# mkpasswd 12
mkpasswd()
{
    # local PATTERN='A-Za-z0-9_!@#$%^&*()\-+='
    local PATTERN='A-Za-z0-9_!-'
    LC_CTYPE=C tr -dc $PATTERN < /dev/urandom | fold -w ${1:-32} | head -n 1 | xargs
}

mcd()
{
    mkdir $1
    cd $1
}

is_installed()
{
    which $1 > /dev/null
}



# Z SHELL
# =================================
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER="asakasinsky"

export UPDATE_ZSH_DAYS=13

# zsh-syntax-highlighting must be placed in LAST position
plugins=(git git-flow osx rails pip ruby github node npm brew zsh-syntax-highlighting)
fpath=(/usr/local/share/zsh-completions $fpath)

# Fish-like term highlighing
# Attention! Those declarations must be after «plugins» declaration
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
        'alias'           'fg=green,bold'
        'builtin'         'fg=yellow'
        'function'        'fg=blue,bold'
        'command'         'fg=green'
        'hashed-commands' 'fg=green,underline'
        'precommand'      'fg=cyan'
        'path'            'underline'
)


# COMPLETION
# =================================

setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE

autoload -U compinit
compinit

# Cache for completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

#Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:default' force-list always

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Autocomplete for kill\killall
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'



source $ZSH/oh-my-zsh.sh

# # TMUX
# # =================================
# alias tmux="tmux -2 -u"
# if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#     tmux attach -t work || ~/Scripts/tmux_work.sh; # exit
# fi


# FIX!
# http://mark.shropshires.net/blog/zsh-compinit-related-error-after-upgrade-os-x-mavericks
# autoload -Uz compinit -u
# compinit -u


# ALIASES
# =================================

alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias vlc=/Applications/VLC.app/Contents/MacOS/VLC

if is_installed grc
then
    alias grc='grc --colour=auto'
    alias ping='grc ping'
    alias last='grc last'
    alias netstat='grc netstat'
    alias traceroute='grc traceroute'
    alias make='grc make'
    alias make='grc diff'
    alias gcc='grc gcc'
    alias configure='grc ./configure'
    alias cat="grc cat"
    alias tail="grc tail"
    alias head="grc head"
else
    echo "Install grc, please";
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# PATHS
# =================================

# Path
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/bin:$HOME/local/bin:$PATH

# Python path
PATH=/usr/local/share/python:$PATH

# Node Path
PATH=$HOME/.node/bin:$PATH
export NODE_PATH=$HOME/.node/lib/node_modules/

# NPM Packages Path
# export PATH=/usr/local/share/npm/bin:$PATH

# haskell - cabal
# export PATH=~/.cabal/bin:$PATH

# TexLive
# PATH=/usr/local/texlive/2013basic/bin/universal-darwin:$PATH

# Android SDK
export ANDROID_HOME=/usr/local/opt/android-sdk


export PATH="$(brew --prefix josegonzalez/php/php55)/bin:$PATH"
PHP_AUTOCONF="/usr/local/bin/autoconf"

export PATH=/usr/local/mysql/bin/:$PATH

JSBIN_CONFIG=~/.jsbin.config.local.json

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
