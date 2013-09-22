#Homebrew

```bash
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```
[Homebrew](http://mxcl.github.com/homebrew/)

Install Git
------------
```bash
brew install git
brew install git-flow
```




Setup Github
------------
```bash
ssh-keygen -t rsa -C "<insert current email>"

#copy ssh key to github.com
subl ~/.ssh/id_rsa.pub

#test connection
ssh -T git@github.com

#set git config values
git config --global user.name "<insert name>"  
git config --global user.email "<insert current email>"  
git config --global github.user <insert username>  

git config --global core.editor "subl -w"  
git config --global color.ui true  
```

Create a [global ignore](https://help.github.com/articles/ignoring-files)
--------------------
```bash
subl ~/.gitignore_global

#add the text below

git config --global core.excludesfile ~/.gitignore_global
```

```text
*~

# Compiled source #
*.com
*.class
*.dll
*.exe
*.o
*.so
*.pyc

# Packages
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
*.log
*.sql
*.sqlite

# OS generated files #
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Icon?
ehthumbs.db
Thumbs.db
```

npm install jshint -g
pip install pudb
brew update
brew tap homebrew/dupes

brew install  ctags
brew install imagesnap
brew install gource

brew install mc ack wget curl memcached libmemcached pkg-config  ffmpeg 

brew install autoconf automake apple-gcc42
sudo ln -s /usr/local/bin/gcc-4.2 /usr/bin/gcc-4.2



## Эмуляция медленного канала


Посредством прокси
www.charlesproxy.com/

Посредством  Network Link Conditioner
Xcode > Open Developer Tool > More Developer Tools…
and get "Hardware IO Tools for Xcode".
