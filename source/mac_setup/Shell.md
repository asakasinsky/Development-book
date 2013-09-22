#Shell

Add subl as sym link   
---------------
```bash
open /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl
ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```

Switch to z-shell
http://ufacode.ru/blog/linux/1094.html#.UjuPcRZQbx4

brew install zsh

which -a zsh
> /usr/local/bin/zsh
> /bin/zsh

sudo nano /etc/shells
Add at end /usr/local/bin/zsh

Change current shell
chsh -s /usr/local/bin/zsh

After reboot 
echo $SHELL
> /usr/local/bin/zsh

echo $ZSH_VERSION
> 5.0.2


---------------
```bash
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

Update .zshrc
-------------
```bash
subl ~/.zshrc
```

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

brew install tmux
SAY ABOUT TMUX
