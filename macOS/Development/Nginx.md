## Nginx-full

```zsh
brew install imagemagick gd
brew tap denji/nginx
brew info nginx-full

brew install nginx-full --with-upload-module --with-gzip-static --with-status --with-image-filter --with-debug

# brew services start|restart|stop denji/nginx/nginx-full
brew services start denji/nginx/nginx-full

# Test it:
curl -IL http://localhost:8080
>>> HTTP/1.1 200 OK
>>> ...

brew info nginx-full

# if you want to serve port 80 instead 8080
sudo chown root:wheel /usr/local/opt/nginx-full/bin/nginx
sudo chmod u+s /usr/local/opt/nginx-full/bin/nginx

# Reload config:
nginx -s reload
# Reopen Logfile:
nginx -s reopen
# Stop process:
nginx -s stop
# Waiting on exit process
nginx -s quit
```


```zsh
mkdir -p /usr/local/etc/nginx/conf.d
mkdir -p /usr/local/etc/nginx/logs
mkdir -p /usr/local/etc/nginx/sites-available
mkdir -p /usr/local/etc/nginx/sites-enabled
mkdir -p /usr/local/etc/nginx/snippets
mkdir -p /usr/local/etc/nginx/ssl
mkdir -p /Users/$(whoami)/Workspace
chmod 775 /Users/$(whoami)/Workspace

cp /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.old

# Nginx Configuration File Example
curl -L https://gist.githubusercontent.com/asakasinsky/0973ba7d27855bf6ab35/raw/159b1d07930f8b63373753cd64f9d6c81f90d747/nginx-osx.conf -o /usr/local/etc/nginx/nginx.conf
```

Check config for error:

```zsh
nginx -t
```

