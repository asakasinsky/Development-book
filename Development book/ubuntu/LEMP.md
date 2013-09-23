[На пути к созданию безопасного веб-ресурса. Часть 1 — серверное ПО](http://habrahabr.ru/post/168739/)

[Nginx boilerplate: Быстрая и изящная настройка nginx](http://habrahabr.ru/post/185788/)

диск 8.6 Гб

7.8 Гб - /

803.2 MB - swap
 
при установке пакетов отмечаем только openssh

--------------

ssh.md

---------------

sudo apt-get -y install nginx mysql-server php5-common php5-mysql php5-fpm sqlite php5-sqlite siege mc memcached
  php5-memcached 

# extra php packages
sudo apt-get -y install php5-cli php5-gd php5-curl php5-xdebug php5-suhosin php-apc

До окончания настроек рекомендуется остановить nginx и php-fpm:

 /etc/init.d/nginx stop;
 /etc/init.d/php5-fpm stop;

Редактируем /etc/nginx/nginx.conf

https://gist.github.com/asakasinsky/6140448

-------
nano /etc/php5/fpm/php.ini


https://gist.github.com/asakasinsky/4611263

------
# PEAR
sudo apt-get -y install php-pear
 
pear upgrade pear
 
# PHPUnit
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony.com
 
sudo pear install --alldeps phpunit/PHPUnit
------

mkdir /home/neon/workspace
http://www.sebdangerfield.me.uk/2012/05/nginx-and-php-fpm-bash-script-for-creating-new-vhosts-under-separate-fpm-pools/
https://www.dropbox.com/home/Public/NGINX

http://howitmake.ru/blog/ubuntu/80.html

---------
MySQL

mysql_secure_installation
разрешаем удалённое подключение
-----------

 



