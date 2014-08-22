# Z shell
# =================================
ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="agnoster"
ZSH_THEME="kphoen"
DEFAULT_USER="asakasinsky"

export UPDATE_ZSH_DAYS=13
plugins=(git git-flow osx rails pip ruby github node npm brew sublime)
fpath=(/usr/local/share/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh


# TMUX
# =================================
alias tmux="tmux -2 -u"
if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t work || ~/Scripts/tmux_work.sh; # exit
fi


# FIX!
# http://mark.shropshires.net/blog/zsh-compinit-related-error-after-upgrade-os-x-mavericks
# autoload -Uz compinit -u
# compinit -u


# ALIASES
# =================================

alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

alias lemp-start="sudo launchctl load -w /Library/LaunchDaemons/UbuntuLEMPServer.plist"
alias lemp-stop="sudo launchctl unload /Library/LaunchDaemons/UbuntuLEMPServer.plist"


# PATHS
# =================================

# Path
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/bin:$HOME/local/bin:$PATH



