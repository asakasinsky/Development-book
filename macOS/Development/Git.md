## Git
```zsh
brew install git git-flow
```

## Github
```zsh
#copy ssh key to github.com
subl ~/.ssh/id_rsa.pub

#test connection
ssh -T git@github.com

#set git config values
git config --global user.name "<insert name>"
git config --global user.email "<insert current email>"
git config --global github.user <insert github username>

git config --global core.editor "subl -w"
git config --global color.ui true

git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.type 'cat-file -t'
git config --global alias.dump 'cat-file -p'


git config core.ignorecase false
```

Create your global ignore file [https://help.github.com/articles/ignoring-files](https://help.github.com/articles/ignoring-files)


...or download my [.gitignore_global](./home/.gitignore_global)


```zsh
git config --global core.excludesfile ~/.gitignore_global
```
