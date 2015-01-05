# Languages

*note: everything executed from Zsh (Z Shell) context, .zlogin will be in the Bash context as .bash_login, for example.*


## RVM: Ruby Version Manager


Install
```bash
curl -L https://get.rvm.io | bash -s stable --ruby
```

Check:
```bash
source ~/.zlogin
type rvm | head -1
```

If not «rvm is a shell function» in output, then
```bash
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.zlogin
source ~/.zlogin
```

Check:

```bash
type rvm | head -1
```


## Ruby 1.9.3 installation

Get last RVM version:
```bash
rvm get head
```

```bash
rvm requirements
rvm pkg install openssl
# versions
# rvm list known
rvm install 2.1.5 
# or rvm reinstall all --force if Ruby allready installed
```

```bash
rvm use 2.1.5 --default
```

Check:
```bash
ruby -v
```


## Install Python 2.7

We will install Python 2.7 with _--universal, --framework_ keys.  
>_**--universal**: to support 32-bit and 64-bit on OS X._  
>_**--framework**: to allow interaction with OS X libraries_  

In this case, these packages must be builded with _--universal_ key.
```bash
brew install gdbm sqlite --universal
```
If they are already installed, then
```bash
brew uninstall gdbm sqlite
brew install gdbm sqlite --universal
```

Now we install python
```bash
brew install python --universal --framework
brew linkapps python
```

```bash
. ~/.zshrc
python --version
> Python 2.7.9
```

```bash
mkdir ~/Frameworks
ln -s "/usr/local/Cellar/python/2.7.8/Frameworks/Python.framework" ~/Frameworks
```


## Install Node.js, npm without «sudo»

```bash
echo 'export PATH=$HOME/.node/bin:$PATH' >> ~/.zshrc
echo 'export NODE_PATH=$NODE_PATH:$HOME/.node/lib/node_modules' >> ~/.zshrc
. ~/.zshrc

mkdir ~/.node
mkdir ~/node-latest-install
cd ~/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=~/.node
make install

# Important!
ln -s ~/.node/bin/node /usr/local/bin/node

node -v
> v0.10.35

. ~/.zshrc
npm install npm -g
npm -v
> 2.1.17
```



```bash
npm install -g grunt grunt-cli jshint jscs yo generator-generator generator-backbone generator-webapp 
```
