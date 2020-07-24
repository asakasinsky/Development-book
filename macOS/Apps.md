_NOTE:   
I use a .zshrc file to configure Zsh (interactive shell).
If your preffered Bash, use .bashrc or .bash_profile instead .zshrc._
 
# Apps

## Command Line Tools

Run in terminal for Command Line Tools installation:
```zsh
xcode-select --install
```


## [Homebrew](http://mxcl.github.com/homebrew/)

``` zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew update
brew install git git-flow 

# Tools
brew install gcc pkg-config autoconf automake cmake
brew install mc wget curl ffmpeg htop imagemagick gd ctags gource ghostscript coreutils gnu-sed ack terminal-notifier pv
```


Tell Homebrew to disable auto-updating
```zsh
echo 'export HOMEBREW_NO_AUTO_UPDATE=1;' >> ~/.zshrc
```


Services:
```zsh
brew tap homebrew/services

# to manage services:
brew services start|restart|stop <service-name>
# Here’s an example usage:
$ brew services start mysql
==> Successfully started `mysql` (label: homebrew.mxcl.mysql)
```

To search for an application:
```zsh
brew search
```

To get info for an application:
```zsh
brew info <package-name>
```

To install for an application:
```zsh
brew install <application-name>
```

To list all apps installed by Homebrew:
```zsh
brew list
```

To remove an installed application:
```zsh
brew remove <application-name>
```

To update Homebrew:
```zsh
brew update
```


## Browsers
[Chrome](https://www.google.com/intl/en/chrome/)

[Firefox](https://www.mozilla.org/en-US/firefox/)

[Chrome Canary](https://www.google.com/intl/en/chrome/canary/)

[Opera](https://www.opera.com/)

[Opera Beta](https://www.opera.com/computer/beta)


## Virtualisation

[VirtualBox](https://www.virtualbox.org/wiki/Downloads)

[VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)


## Markdown

[Marked2](https://marked2app.com/)

[Marked Bonus Pack (I use Services and Sublime Text 3 build script)](https://github.com/kotfu/marked-bonus-pack)

[Markdown Service Tools](https://brettterpstra.com/projects/markdown-service-tools/)


## Required apps

[Sublime Text 3](https://www.sublimetext.com/)

Add symlink to sublime
```zsh
# Test
open /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
# Symlink
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```

[iTerm 2](https://iterm2.com/downloads.html)  
[Inline Images Protocol](https://www.iterm2.com/documentation-images.html)


[RESTed](https://apps.apple.com/us/app/rested-simple-http-requests/id421879749)

[Dash App](https://kapeli.com/dash)

[ForkLift](https://apps.apple.com/ru/app/forklift-file-manager-ftp/id412448059)

[ImageOptim](https://imageoptim.com/mac)

[DiffMerge](https://sourcegear.com/diffmerge/downloads.php)

[Araxis Merge](https://www.araxis.com/merge/download.en)


## MySQL

[Sequel Pro](https://sequelpro.com/download)  
[Sequel Pro Nightly Build](https://sequelpro.com/test-builds) (Mysql 8)  
[MySQL Workbench](https://www.mysql.com/products/workbench/)


## Productivity

[nvALT](https://brettterpstra.com/projects/nvalt/#dl)

[Apptivate](http://www.apptivateapp.com/)


#### My hotkeys for Apptivate

```txt
⌥ + 1 Chrome
⌥ + 2 Sublime
⌥ + 3 iTerm
⌥ + 4 Dash
⌥ + Z nvALT
⌥ + S Safari
⌥ + M Mail
```


[Evernote without AppStore](https://evernote.com/intl/ru/download)

[XMind](https://www.xmind.net/download/)  
[iThoughtsX](https://www.toketaware.com)

[1Password](https://agilebits.com/onepassword)

[Pocket](https://apps.apple.com/ru/app/pocket/id568494494)

[Twitter](https://apps.apple.com/ru/app/twitter/id409789998)

[Skype](https://www.skype.com/en/get-skype/)

[VLC](https://www.videolan.org/vlc/)  
[Youtube playlist](	)  
[Tunein-Radio-VLC](https://addons.videolan.org/p/1153982/)  

[Adium](https://adium.im/)


## Backups cloudstore

[Dropbox](https://www.dropbox.com/) (has a file version history!)

[Yandex.Disk](https://disk.yandex.ru/download#pc)


## Useful tools

[How to schedule Time Machine backups](http://www.klieme.com/TimeMachineScheduler.html)

[Unarchiver](https://theunarchiver.com)

[Wireshark](https://www.wireshark.org/download.html)

[f.lux](https://justgetflux.com/)

[AppCleaner](https://freemacsoft.net/appcleaner/)

[XLD](https://sourceforge.net/projects/xld/)

[LICEcap](https://www.cockos.com/licecap/)

[TeamViewer](https://www.teamviewer.com/ru/download/mac.aspx)

## Privacy

[dnscrypt-osx-client](https://dnscrypt.info/implementations)

[TorBrowser](https://www.torproject.org/download/)

[GPG Suite](https://gpgtools.org/)
