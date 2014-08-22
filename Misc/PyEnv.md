## Pyenv: Simple Python Version Management

### Prepare

```bash
sudo apt-get install git make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev

git clone git://github.com/yyuu/pyenv.git ~/.pyenv
```

from <code>man bash</code>:

>  When bash is invoked as an interactive login shell, or as  a  non-interac-
   tive  shell  with the --login option, it first reads and executes commands
   from the file /etc/profile, if that file exists.  After reading that file,
   it  looks  for  ~/.bash_profile,  ~/.bash_login,  and  ~/.profile, in that
   order, and reads and executes commands from the first one that exists  and
   is readable.  The --noprofile option may be used when the shell is started
   to inhibit this behavior.

In one of these files (~/.bash_profile,  ~/.bash_login,  and  ~/.profile) , you can see tthe code like this:

```bash
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
```

if not, then just add this code in _~/.bash_profile_


### Install

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
. ~/.bashrc
```


Install multiple versions of python:
```bash
pyenv install 2.7.7
pyenv install 3.4.1

pyenv rehash
pyenv versions
```

Please read [«Command Reference»](https://github.com/yyuu/pyenv/blob/master/COMMANDS.md)

## Pyenv-virtualenv: A Pyenv Plugin To Manage Virtualenv

```bash
mkdir -p ~/.pyenv/plugins
git clone git://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone git://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
```

Please read [«Using pyenv virtualenv with pyenv»](https://github.com/yyuu/pyenv-virtualenv#using-pyenv-virtualenv-with-pyenv)

### Use Case

```bash
$ pyenv versions
* system (set by /root/.pyenv/version)
  2.7.7
  3.4.1

$ mkdir -p ~/projects/test && cd ~/projects/test

$ pyenv virtualenv --no-site-packages 2.7.7 venv-2.7.7

$ pyenv local venv-2.7.7

$ pip install pytz

$ pip freeze
pytz==2014.4
wsgiref==0.1.2

$ python --version
Python 2.7.7

$ cd ..

$ python --version
Python 2.7.6
```

Pyenv creates a file in the directory _.python-version_ which contains the information about what version of python with which environment to use for this project. Virtualenv is activated automatically when you _cd_ in the project folder.

## Useful Links

[github.com/yyuu/pyenv](https://github.com/yyuu/pyenv)
[github.com/yyuu/pyenv-installer](https://github.com/yyuu/pyenv-installer)
[github.com/yyuu/pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv)
[github.com/yyuu/pyenv-virtualenvwrapper](https://github.com/yyuu/pyenv-virtualenvwrapper)
[docs.python.org/dev/library/venv.html](https://docs.python.org/dev/library/venv.html)
[virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)
[virtualenvwrapper.readthedocs.org/en/latest/](http://virtualenvwrapper.readthedocs.org/en/latest/)
