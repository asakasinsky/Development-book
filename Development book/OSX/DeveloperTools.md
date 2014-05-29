# Developer tools


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
curl https://raw.github.com/beautifulcode/ssh-copy-id-for-OSX/master/ssh-copy-id.sh -o /usr/local/bin/ssh-copy-id
chmod +x /usr/local/bin/ssh-copy-id
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

Create a [global ignore](https://help.github.com/articles/ignoring-files)
```bash
subl ~/.gitignore_global
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

```bash
git config --global core.excludesfile ~/.gitignore_global
```

## Jshint
```bash
npm install jshint -g
```

## PuDB (console-based visual debugger for Python)
```bash
pip install pudb
```

## Useful tools
brew install ctags cmake imagesnap gource ghostscript imagemagick htop gnu-sed siege

## Speed limit network to simulate the «bad» connection

[Speed Limit](http://mschrag.github.io/)

__Network Link Conditioner Tool:__
Xcode > Open Developer Tool > More Developer Tools... and get "Hardware IO Tools for Xcode".

__Ipfw__ — out-the-box command line firewall:

```bash
# Set rules
sudo ipfw pipe 1 config bw 128Kbit/s delay 200ms
sudo ipfw add 1 pipe 1 src-port 80

# To remove all rules and recover your original network connection
sudo ipfw flush
```
