## ElasticSearch ver 6.8

```zsh
brew cask install homebrew/cask-versions/adoptopenjdk8
brew tap elastic/tap
brew info elasticsearch@6.8
brew install elasticsearch@6.8

# brew services start|restart|stop elasticsearch
brew services start elasticsearch@6

curl -XGET 'http://127.0.0.1:9200'
```

Would be very useful...
__[elasticdump](https://www.npmjs.com/package/elasticdump)__
```zsh
npm install elasticdump -g
```
