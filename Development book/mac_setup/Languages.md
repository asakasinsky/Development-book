
Install rvm
-------------
```bash
curl -L https://get.rvm.io | bash -s stable --ruby
```

# Вбиваем:
type rvm | head -1
source ~/.zlogin

# Если не видим rvm is a shell function, то
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.zlogin
source ~/.zlogin

#Проверяем: 
type rvm | head -1


Ставим Ruby 1.9.3
-------------
# Обновляем RVM до последней версии:
rvm get head

#Подготовка и установка:
rvm requirements

rvm pkg install openssl
rvm install 1.9.3 # илиa rvm reinstall all --force если у вас уже установлен Ruby)


# Говорим, чтобы использовалась именно эта версия:
rvm use 1.9.3 --default

#Проверяем:
ruby -v




Install python
------------
$ brew install readline gdbm sqlite --universal
if >> python dependency sqlite not installed with: --universal
  brew remove sqlite
	brew install sqlite --universal

$ brew install python --universal --framework
[Why with the framework and universal links](http://www.thisisthegreenroom.com/2011/installing-python-numpy-scipy-matplotlib-and-ipython-on-lion/#python)

$ python --version
Python 2.7.5


$ mkdir ~/Frameworks
$ ln -s "/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework" ~/Frameworks

$ curl -O http://python-distribute.org/distribute_setup.py
$ python distribute_setup.py
$ easy_install pip
$ pip install distribute



Add to .bashrc:
# Before other PATHs...
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

Install virtualenv
$ pip install virtualenv 
$ pip install virtualenvwrapper

Test setup
$ mkvirtualenv test 
$ rmvirtualenv test


Install Node.js [Directions](http://shapeshed.com/setting-up-nodejs-and-npm-on-mac-osx/)
------------------------
```bash
brew install node
npm install grunt-cli -g
