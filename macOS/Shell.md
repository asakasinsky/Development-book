## iTerm + Z shell + tmux

## iTerm 

iTerm was suggested to install [earlier](./Apps.md)
iTerm предлагалось установить [ранее](./Apps.md), now is the time to start it.

## Switch to Z-shell

```zsh
brew install zsh
brew install zsh-completions
touch ~/.zshrc
```

Copy next lines and add them to your .zshrc for  zsh-completions activation
```zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
```


Check Zsh paths
```zsh
which -a zsh
> /usr/local/bin/zsh
> /bin/zsh
```

Add Zsh path into /etc/shells if not exists
```zsh
sudo nano /etc/shells
```

Switch to Zsh
```zsh
chsh -s /bin/zsh
```

Open new iTerm window, if you receive "zsh compinit: insecure directories" warnings — run this:
```zsh
cd /usr/local/share/
sudo chmod -R 755 zsh
sudo chown -R root:staff zsh
```

Check current shell
```zsh
echo $SHELL

> /bin/zsh
```

```zsh
echo $ZSH_VERSION
> 5.3
```


You may force rebuild `zcompdump`:
```zsh
rm -f ~/.zcompdump; compinit
```

## Prezto

[https://github.com/sorin-ionescu/prezto](https://github.com/sorin-ionescu/prezto)


## Tmux
```zsh
brew install tmux
brew install reattach-to-user-namespace
```


## Configuration File Examples

[.zshrc](https://raw.githubusercontent.com/asakasinsky/Development-book/master/macOS/shell/.zshrc)

[.tmux.conf](https://raw.githubusercontent.com/asakasinsky/Development-book/master/macOS/shell/.tmux.conf)

[Scripts/tmux_work.sh](https://raw.githubusercontent.com/asakasinsky/Development-book/master/macOS/shell/Scripts/tmux_work.sh  )


## Fonts

I really like the Inconsolata LGC font for a console and IDE/

[This link](https://github.com/asakasinsky/Inconsolata-LGC/archive/master.zip) can download the Inconsolata-LGC archive with ttf, including Cyrillic and Powerline glyphs.
Powerline glyphs is needed for "agnoster" zsh theme.

[FiraCode: Monospaced font with programming ligatures](https://github.com/tonsky/FiraCode)
