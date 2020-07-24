#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export CLICOLOR=1
# Define colors for BSD ls.
export LSCOLORS='ExFxBxDxCxegedabagacad'

# # Define colors for the completion system.
export LS_COLORS='di=01;36:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'


export GREP_COLORS="mt=33"
export GREP_OPTIONS='--color=auto'


# alias ls='ls -GFh'

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

# if is_installed grc
# then
#     alias grc='grc --colour=auto'
#     alias ping='grc ping'
#     alias last='grc last'
#     alias netstat='grc netstat'
#     alias traceroute='grc traceroute'
#     alias make='grc make'
#     alias diff='grc diff'
#     alias gcc='grc gcc'
#     alias configure='grc ./configure'
#     alias cat="grc cat"
#     alias tail="grc tail"
#     alias head="grc head"
# else
#     echo "Install grc, please";
# fi

if is_installed tmux
then
 # TMUX
 # =================================
 alias tmux="tmux -2 -u";
 # if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
 #    tmux attach -t work || ~/Scripts/tmux_work.sh; # exit
 # fi
else
    echo "Install tmux, please";
fi

# PATHS
# =================================

# Path
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/bin:$HOME/local/bin:$PATH

# Python path
export PYTHONSTARTUP="${HOME}/.pyrc"
export PYTHONIOENCODING="UTF-8"

# Python Homebrew version path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Node Path
PATH=$HOME/.node/bin:$PATH
export NODE_PATH=$NODE_PATH:$HOME/.node/lib/node_modules/

# NPM Packages Path
# export PATH=/usr/local/share/npm/bin:$PATH

# haskell - cabal
# export PATH=~/.cabal/bin:$PATH

# TexLive
# PATH=/usr/local/texlive/2013basic/bin/universal-darwin:$PATH

# Lolcommits
# export LOLCOMMITS_DELAY=3

# Android SDK
# export ANDROID_HOME=/usr/local/opt/android-sdk

# ARM Toolchain
export PATH="/usr/local/opt/arm-toolchain:$PATH"

# Composer PHP
export PATH="~/.composer/vendor/bin:$PATH"


PHP_AUTOCONF="/usr/local/bin/autoconf"

export PATH=/usr/local/mysql/bin:$PATH

# JSBIN_CONFIG=~/.jsbin.config.local.json

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
eval "$(pyenv virtualenv-init -)"

source ~/.bash_aliases
