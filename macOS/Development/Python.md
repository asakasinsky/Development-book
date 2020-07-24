_NOTE:   
I use a .zshrc file to configure Zsh (interactive shell).
If your preffered Bash, use .bashrc or .bash_profile instead .zshrc._
 


## Python 3.8 (system-wide, via Homebrew)

Now we install python
```zsh
brew install python
```

Telling your Linux shell where to look python via $PATH variable
```zsh
echo 'export PATH="/usr/local/opt/python/libexec/bin:$PATH"' >> ~/.zshrc
```

Reload your .zshrc with preserve your current shell session and its state
```zsh
# next line is the shorter version of the command source ~/.zshrc
. ~/.zshrc 
```

... or open new terminal window and check python version
```zsh
python --version
> Python 3.8.5

pip --version
> pip 19.3.1 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
```


__Updating without re-brewing Python__
```zsh
# Setuptools can be updated via pip, :
python -m pip install --upgrade setuptools
# pip can be used to upgrade itself via:
python -m pip install --upgrade pip
```


## Pyenv — Python Virtual Environment

Please read [«Command Reference»](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md).

__Installation__

```zsh
brew install pyenv
```

__Configuration (zsh)__

```zsh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
. ~/.zshrc
```


__Install multiple versions of python__

```zsh

# Flags: 
# -l/--list   Lists all available Python versions for installation
# -g/--debug  Builds a debug version of Python
# -v/--verbose    Verbose mode: print compilation status to stdout

pyenv install -l


# How to build CPython with Framework support on OS X
# env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 2.7.18

pyenv install 2.7.18
pyenv install 3.7.8

pyenv rehash
pyenv versions

```

__Uninstall python version__

```zsh
pyenv uninstall <version>
```


__Pyenv-virtualenv: A Pyenv Plugin To Manage Virtualenv__

Please read [«Using pyenv virtualenv with pyenv»](https://github.com/pyenv/pyenv-virtualenv#using-pyenv-virtualenv-with-pyenv)

```zsh
git clone git://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone git://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
. ~/.zshrc
```

Pyenv creates a file in the directory _.python-version_ which contains the information about what version of python with which environment to use for this project. Virtualenv is activated automatically when you _cd_ in the project folder.


__Usage Example__

```zsh
$ pyenv versions
* system (set by /Users/asakasinsky/.pyenv/version)
  2.7.18
  3.7.8

$ mkdir -p ~/projects/test && cd "$_"

$ pyenv virtualenv 2.7.18 my-test-venv

$ pyenv local my-test-venv

$ python --version
Python 2.7.18

$ pip install pytz

$ pip freeze
pytz==2020.1

$ cd ..

$ python --version
Python 3.8.5 (system-wide version)

# Cleanup
$ cd ~
$ rm -rf ~/projects/test
$ pyenv uninstall my-test-venv


```

__Useful Links__

- [github.com/pyenv/pyenv](https://github.com/pyenv/pyenv)
- [github.com/pyenv/pyenv-installer](https://github.com/pyenv/pyenv-installer)
- [github.com/pyenv/pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
- [github.com/pyenv/pyenv-virtualenvwrapper](https://github.com/pyenv/pyenv-virtualenvwrapper)
- [docs.python.org/dev/library/venv.html](https://docs.python.org/dev/library/venv.html)
- [virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)
- [virtualenvwrapper.readthedocs.org/en/latest/](http://virtualenvwrapper.readthedocs.org/en/latest/)
