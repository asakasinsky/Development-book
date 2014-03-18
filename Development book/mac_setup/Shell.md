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

[My .zshrc example](/Development%20book/mac_setup/shell/.zshrc)

## Tmux a terminal multiplexer

```bash  
brew install tmux  
```

[.tmux.conf](/Development%20book/mac_setup/shell/.tmux.conf)
Put .tmux.conf in ~/

[tmux_conf.sh](/Development%20book/mac_setup/shell/tmux_conf.sh)
Put tmux_conf.sh in ~/Scripts (this script called from [.zshrc](/Development%20book/mac_setup/shell/.zshrc))



