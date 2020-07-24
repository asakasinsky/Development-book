_NOTE:   
I use a .zshrc file to configure Zsh (interactive shell).
If your preffered Bash, use .bashrc or .bash_profile instead .zshrc._
 
# Node.js

## Single Version

__Official installer__
[Download | Node.js](https://nodejs.org/en/download/)

__Via Homebrew__

```zsh
# current stable version
brew install node

# specific version
brew search node
> node node@12 node@10 ...

brew install <node-version>
```

## Multiple Version via Node Version Manager

```zsh
brew update
brew install nvm
mkdir ~/.nvm
```

Add the following to .zshrc
```zsh
export NVM_DIR=~/.nvm
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
```

Activate nvm and check it:
```zsh
# next line is the shorter version of the command source ~/.zshrc
. ~/.zshrc 
echo $NVM_DIR
```

Fix an «nvm-exec: No such file or directory» error.
Nvm exec fails, because it looks for nvm-exec in $HOME/.nvm, which only contains the localized Node installs, not nvm.
```zsh
ln -s "$(brew --prefix)/opt/nvm/nvm.sh" "$NVM_DIR/nvm.sh"
ln -s "$(brew --prefix)/opt/nvm/nvm-exec" "$NVM_DIR/nvm-exec"
```


### Useful commands

```zsh
# list available remote versions of node (via nvm)
nvm ls-remote

# Grep what you want
nvm ls-remote | grep -i 'latest'
nvm ls-remote | grep -i 'v10'

# list installed versions of node (via nvm)
nvm ls

# install specific version of node
nvm install 10.18.1

# set default version of node
nvm alias default 10.18.1

# switch version of node
nvm use 12.14.1
```


### Locking down a specific node version in your project
Just add a .nvmrc file with node version.  
v10.18.1, for example.
```zsh
touch .nvmrc
echo "v10.18.1" >> .nvmrc
```

Afterwards, run the commands below:
```zsh
nvm use
nvm install
nvm exec
nvm run
nvm which
```


## Yarn 
```zsh
brew install yarn
```
