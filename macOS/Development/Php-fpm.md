_NOTE:   
I use a .zshrc file to configure Zsh (interactive shell).
If your preffered Bash, use .bashrc or .bash_profile instead .zshrc._
 

## Php-fpm (v7.2)

```zsh
brew install autoconf cmake automake libtool m4 openssl  zlib memcached libmemcached
brew services start memcached
brew install php@7.2
```

Add the following to .zshrc
```zsh
echo 'export PATH="/usr/local/opt/php@7.2/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/php@7.2/sbin:$PATH"' >> ~/.zshrc
# next line is the shorter version of the command source ~/.zshrc
. ~/.zshrc 
```


Version checking, pecl package installation
```zsh
php -v
> PHP 7.2.32

pecl update-channels
pecl install apcu
pecl install xdebug
pecl install igbinary
pecl install memcached # All by defaults (autodetect)
pecl install imagick
```

To launch php-fpm on startup:
```zsh
brew services start php@7.2
```

Configuration files:
```txt
# php.ini
/usr/local/etc/php/7.2/php.ini

# php-fpm.ini
/usr/local/etc/php/7.2/php-fpm.conf

# gsed (gnu-sed) was installed early, view [Apps.md](../Apps.md)
sudo gsed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /usr/local/etc/php/7.2/php.ini

# Config test
php-fpm -t
```


__Composer__
```zsh
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod 755 /usr/local/bin/composer
mkdir -p $HOME/.composer

# Updating
composer self-update
```


## Php-fpm (v5.6)

```zsh
brew tap exolnet/homebrew-deprecated
brew install php@5.6
```

If openssl v1.0 dependency error occurs, then install php 5.6 using the formula from [this pull request](https://github.com/eXolnet/homebrew-deprecated/pull/25)
```zsh
brew install --build-from-source https://raw.githubusercontent.com/JParkinson1991/homebrew-deprecated/79d817a7ef794234d5276df0487a9d037b7b7bba/Formula/php@5.6.rb --with-openssl-1.1-patch
```

To launch php-fpm on startup:
```zsh
brew services start exolnet/deprecated/php@5.6
```
