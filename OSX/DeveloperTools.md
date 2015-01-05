# Developer tools

## Useful tools
```bash
brew install git git-flow ctags cmake imagesnap gource ghostscript imagemagick htop iotop gnu-sed siege terminal-notifier
```


## Setup SSH

Generate rsa-keys. Generated public and private keys will be put in the ~/.ssh folder
```bash
ssh-keygen -t rsa -C "мой-email@mail-bla-bla.com"
```

Add the rsa-key to ssh-agent.
```bash
ssh-add ~/.ssh/id_rsa
```

Set permissions:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
```

For easy addition of keys on the server there is a utility ssh-copy-id, but OSX is not available, install it
```bash
curl -L https://raw.githubusercontent.com/beautifulcode/ssh-copy-id-for-OSX/master/install.sh | sh
```

Now you can easily add the public key to the server (you'll need a password)
```bash
ssh-copy-id user@server # user - username (login),
                        # server - server IP or domain
```

Enter by SSH (no password, hooray!).
```bash
ssh user@server         # user - username (login),
                        # server - server IP or domain
```

## Install Git
```bash
brew install git git-flow
```

## Setup Github
```bash
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

Create your global ignore file [https://help.github.com/articles/ignoring-files](https://help.github.com/articles/ignoring-files)


...or download my [.gitignore_global](./home/.gitignore_global)


```bash
git config --global core.excludesfile ~/.gitignore_global
```

## Jshint
> JSHint is a community-driven tool to detect errors and potential problems in JavaScript code and to enforce your team's coding conventions.  
> [http://jshint.com/about/](http://jshint.com/about/)  
```bash
npm install jshint -g
```

My .jshintrc [is here](./home/.jshintrc)

## Jscs
> JSCS — JavaScript Code Style.  
> JSCS is a code style linter for programmatically enforcing your style guide. You can configure JSCS for your project in detail using over 90 validation rules, including presets from popular style guides like jQuery, Airbnb, Google, and more.  
> [http://jscs.info/](http://jscs.info/)  
```bash
npm install jscs -g
```

My .jscsrc [is here](./home/.jscsrc)


## PuDB
> PuDB is a full-screen, console-based visual debugger for Python.  
> [https://pypi.python.org/pypi/pudb](https://pypi.python.org/pypi/pudb)  
```bash
pip install pudb
```

## JS-beautify
> This little beautifier will reformat and reindent bookmarklets, ugly JavaScript, unpack scripts packed by Dean Edward’s popular packer, as well as deobfuscate scripts processed by javascriptobfuscator.com.  
> [https://github.com/beautify-web/js-beautify](https://github.com/beautify-web/js-beautify)  
```bash
pip install jsbeautifier
```

You can install an ST3 plugin [https://github.com/victorporof/Sublime-HTMLPrettify](https://github.com/victorporof/Sublime-HTMLPrettify)


My .jsbeautifyrc [is here](./home/.jsbeautifyrc)

## Sublime-Csscomb
> Sublime plugin for CSScomb—CSS coding style formatter  
> [https://github.com/csscomb/sublime-csscomb](https://github.com/csscomb/sublime-csscomb)  

My .csscomb.json [is here](./home/.csscomb.json)

## EditorConfig
> What is EditorConfig?  
> EditorConfig helps developers define and maintain consistent coding styles between different editors and IDEs. The EditorConfig project consists of a file format for defining coding styles and a collection of text editor plugins that enable editors to read the file format and adhere to defined styles. EditorConfig files are easily readable and they work nicely with version control systems.  
> [http://editorconfig.org/](http://editorconfig.org/)  

My .editorconfig [is here](./home/.editorconfig)

## Sublime Text 3 Config
My Preferences.sublime-settings [is here](./home/Preferences.sublime-settings)



## [Xcode](https://developer.apple.com/xcode/)

Xcode > Preferences > Downloads > __Command Line Tools__

Xcode > Preferences > Downloads > __iOS * Simulator__


## Speed limit network to simulate the «bad» connection

__Speed Limit Preference Pane:__  
[Download Link](http://mschrag.github.io/)

__Network Link Conditioner Tool:__  
Xcode > Open Developer Tool > More Developer Tools... and get "Hardware IO Tools for Xcode".

__Ipfw__  
Out-the-box command line firewall:  
```bash
# Set rules
sudo ipfw pipe 1 config bw 128Kbit/s delay 200ms
sudo ipfw add 1 pipe 1 src-port 80

# To remove all rules and recover your original network connection
sudo ipfw flush
```
