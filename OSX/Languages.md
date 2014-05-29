# Languages

*note: everything executed from Zsh (Z Shell) context, .zlogin will be in the Bash context .bash_login, for example.*


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
rvm install 1.9.3 # or rvm reinstall all --force if Ruby allready installed
```

```bash
rvm use 1.9.3 --default
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
```

```bash
. ~/.zshrc
python --version
> Python 2.7.6
```

```bash
mkdir ~/Frameworks
ln -s "/usr/local/Cellar/python/2.7.6/Frameworks/Python.framework" ~/Frameworks
```

```bash
curl -O http://python-distribute.org/distribute_setup.py
python distribute_setup.py
easy_install pip
pip install distribute
```

Add to .bashrc Before other PATHs:
```bash
export PATH=/usr/local/share/python:$PATH

# Python
# This creates the functions for the wrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi
```

Install virtualenv
```bash
pip install virtualenv
pip install virtualenvwrapper
```

Test setup
```bash
mkvirtualenv test
rmvirtualenv test
```


## Install Node.js

[Use one of these techniques to install node and npm without having to sudo](https://gist.github.com/isaacs/579814)

```bash
echo 'export PATH=$HOME/.node/bin:$PATH' >> ~/.zshrc
echo 'export NODE_PATH=$HOME/.node/lib/node_modules/' >> ~/.zshrc
. ~/.zshrc

mkdir ~/.node
mkdir ~/node-latest-install
cd ~/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=~/.node
make install # ok, fine, this step probably takes more than 30 seconds...
curl https://www.npmjs.org/install.sh | sh
```

```bash
npm install -g grunt grunt-cli jshint yo generator-generator generator-backbone generator-webapp generator-chaplin
```
