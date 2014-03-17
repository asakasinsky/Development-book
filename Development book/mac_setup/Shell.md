# Shell

## Switch to z-shell

```bash  
brew install zsh  
brew install zsh-completions  
```

```bash  
which -a zsh  
> /usr/local/bin/zsh  
> /bin/zsh  
```

Add location (/usr/local/bin/zsh) at end of /etc/shells  
```bash  
sudo nano /etc/shells  
``` 

Change current shell  
```bash  
chsh -s /usr/local/bin/zsh  
```

After reboot  
```bash  
echo $SHELLecho $SHELL

> /usr/local/bin/zsh  
```

```bash  
echo $ZSH_VERSION  
> 5.0.2  
```

## Install Oh-my-zsh

```bash  
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh  
```

```bash  
nano ~/.zshrc  
```

Add to .zshrc

```bash  
ZSH=$HOME/.oh-my-zsh  
ZSH_THEME="robbyrussell"  
alias zshconfig="subl ~/.zshrc"  
alias ohmyzsh="subl ~/.oh-my-zsh"  
plugins=(git brew git-flow osx pip sublime vagrant)  
source $ZSH/oh-my-zsh.sh  
export PATH=/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin  
```  
[ZSH Plugins](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins)

## Tmux a terminal multiplexer

```bash  
brew install tmux  
```

_~/.tmux.conf_  
```bash  
# tmux config by proft [http://proft.me]

# base  
set -g set-titles on  
set -g set-titles-string "#H > #W"

# automatically set window title  
setw -g automatic-rename

set -g base-index 1

set -g history-limit 5000

# mouse scrolling  
set -g mode-mouse on

set-option -g mouse-resize-pane on  
# Resize panes with the mouse.

set-option -g mouse-select-pane on  
# Select panes with the mouse.

#set window notifications  
#setw -g monitor-activity on  
#set -g visual-activity on

set -g display-time 2000  
set -g status-interval 10

set -g status-left ''  
set -g status-right '#[fg=green][#H]#[fg=cyan][#(cut -d " " -f 1-3 /proc/loadavg)]#[fg=yellow][%H:%M, %d-%m-%y]'  
set -g status-right-length 45

# colors  
set -g status-fg white  
set -g status-bg default  
set -g status-attr default

set-window-option -g window-status-fg cyan  
set-window-option -g window-status-bg default  
set-window-option -g window-status-attr dim

set-window-option -g window-status-current-fg white  
set-window-option -g window-status-current-bg default  
set-window-option -g window-status-current-attr bright


set -g message-fg white  
set -g message-bg black  
set -g message-attr bright

# keys  
unbind C-b  
set -g prefix C-a

set -g status-keys vi  
setw -g mode-keys vi

# switch between tabs with alt+larrow && alt+rarrow  
bind-key -n M-Right next  
bind-key -n M-Left prev

# vim resize panel  
bind < resize-pane -L 1  
bind > resize-pane -R 1

# splitting  
unbind %  
bind h split-window -h  
unbind '"'  
bind v split-window -v

# last window  
unbind l  
bind a last-window

# reload config  
bind r source-file ~/.tmux.conf

# kill current window  
bind-key k confirm kill-window

# detach  
bind-key -n C-j detach

# switch windows alt+number  
bind-key -n M-1 select-window -t 1  
bind-key -n M-2 select-window -t 2  
bind-key -n M-3 select-window -t 3  
bind-key -n M-4 select-window -t 4  
bind-key -n M-5 select-window -t 5  
bind-key -n M-6 select-window -t 6  
bind-key -n M-7 select-window -t 7  
bind-key -n M-8 select-window -t 8  
bind-key -n M-9 select-window -t 9

set -g update-environment "SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION"  
```

_~/Scripts/tmux_conf.sh_  
```bash  
#!/bin/bash

tmux new-session -d -s work

tmux new-window -t work:1  
tmux new-window -t work:2  
tmux new-window -t work:3



# Split second window in «work» session  
tmux split-window -dv -p 50 -t work:2.0  
tmux split-window -dh -p 50 -t work:2.1

tmux send-keys -t work:1. 'cd ~/Workspace/;mc' C-m

tmux send-keys -t work:2.1 'uptime' C-m  
tmux send-keys -t work:2.2 'cd ~/Workspace/' C-m  
tmux send-keys -t work:2. 'cd ~/Desktop/' C-m

tmux send-keys -t work:3. 'htop' C-m


tmux select-window -t work:2  
tmux -2 attach-session -t work  
```
