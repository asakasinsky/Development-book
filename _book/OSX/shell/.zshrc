ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kphoen"
export UPDATE_ZSH_DAYS=13
plugins=(git git-flow osx rails pip ruby github node npm brew sublime)


# ALIASES

alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"


# Servers

alias neon-start="sudo launchctl load -w /Library/LaunchDaemons/UbuntuLEMPServer.plist"
alias neon-stop="sudo launchctl unload /Library/LaunchDaemons/UbuntuLEMPServer.plist"


# PATHS

# Path
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH

# Python path
export PATH=/usr/local/share/python:$PATH

# NPM Packages Path
export PATH=/usr/local/share/npm/bin:$PATH

# haskell - cabal
export PATH=~/.cabal/bin:$PATH

# TexLive
PATH=/usr/local/texlive/2013basic/bin/universal-darwin:$PATH

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
if [[ -r  /usr/local/bin/virtualenvwrapper.sh ]]; then
    source  /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi


# http://mark.shropshires.net/blog/zsh-compinit-related-error-after-upgrade-os-x-mavericks
autoload -Uz compinit -u
compinit -u

source $ZSH/oh-my-zsh.sh

# tmux
alias tmux="tmux -2 -u"
if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t work || ~/scripts/tmux_work.sh; # exit
fi


