
# PHP For Ubuntu >= 18.04

The main PPA for supported PHP versions with many PECL extensions  
https://launchpad.net/~ondrej/+archive/ubuntu/php  

```bash
# WARNING: add-apt-repository is broken with non-UTF-8 locales, see https://github.com/oerdnj/deb.sury.org/issues/56 for workaround:
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt update
## !!! Апгрейд не проводим !!!
```

```bash
## Устанавливаем PHP 7.2
#
# PHP: Миграция из PHP 5.6.x к PHP 7.0.x - Manual
# https://php.net/manual/ru/migration70.php
# PHP: Миграция с PHP 7.0.x на PHP 7.1.x - Manual
# https://php.net/manual/ru/migration71.php
# PHP: Миграция с PHP 7.1.x на PHP 7.2.x - Manual
# https://php.net/manual/ru/migration72.php
# PHP: Миграция с PHP 7.2.x на PHP 7.3.x - Manual
# https://php.net/manual/ru/migration73.php
# PHP: Миграция с PHP 7.3.x на PHP 7.4.x - Manual
# https://www.php.net/manual/ru/migration74.php

sudo apt install php7.2 php7.2-fpm php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline
sudo apt upgrade
sudo apt autoremove

php -v



# Если запущен сервис php7.2-fpm
sudo systemctl {start|stop|status} php7.2-fpm
# то выключаем его
sudo systemctl stop php-fpm
#  выключаем его
sudo systemctl start php7.2-fpm
```

Проверяем версию
```bash
php -v
```


```
sudo apt install php-pear php-imagick php-memcached php-amqp sqlite3 php7.2-curl php7.2-gd php7.2-imap php7.2-intl php7.2-json php7.2-ldap php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-pspell php7.2-readline php7.2-soap php7.2-xml php7.2-zip php7.2-dev php7.2-sqlite3 php7.2-xmlrpc php7.2-xsl php7.2-bcmath
```

PHPSTORM XDEBUG ubuntu NGINX php7.2-fpm  
https://gist.github.com/me7media/6291827bb44b7e90e905ff8bdda8182e  
longxinH/xhprof: PHP7 support  
https://github.com/longxinH/xhprof  
Профилирование PHP7 кода с использованием xhprof  
http://codengineering.ru/post/43   


## Composer

Ставим Composer (глобально, на уровне системы; команда «composer» вместо локального «php composer.phar» )

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

Обновление Composer
```bash
composer self-update
```

Немного безопасности

```bash
sudo nano /etc/php/7.2/fpm/php.ini

# В текстовом редакторе открываем php.ini
# Меняем **;cgi.fix_pathinfo=1** на **cgi.fix_pathinfo=0**
sudo nano /etc/php/7.2/fpm/php.ini

# или делаем это простой командой замены текста через sed
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini

```


Рестарт php

```bash
sudo systemctl restart php7.2-fpm
```


Управление php7.2-fpm
```bash
sudo systemctl {start|stop|restart|status} php7.2-fpm
```
Поверка работы php-fpm (вывод процессов)
```bash
ps -ef|grep php-fpm
```

Проверка конфигов:
```bash
php-fpm7.2 -t
```

Как найти загруженную конфигурацию php-fpm
php-fpm7.2 -i | grep php.ini
Как найти загруженную конфигурацию php-cli
php7.2 -i | grep php.ini




#### То, что ниже - информация к размышлению

```
ps -ylC php-fpm7.2 --sort:rss | awk '!/RSS/ { s+=$8 } END { printf "%s\n", "Total memory used by PHP-FPM child processes: "; printf "%dM\n", s/1024 }'

free -m

5967-(1500+768)/400
3699/300=12,33
```

PHP: Настройка - Manual
http://php.net/manual/ru/install.fpm.configuration.php

Оптимизация PHP-FPM: Используем ‘pm static’ для максимальной производительности
http://phpprofi.ru/blogs/post/70

Настраиваем php-fpm · Блог Новикова Богдана
https://hcbogdan.com/php/2016/09/16/php-fpm-dynamic/




The configuration variable pm.max_children controls the maximum amount of FPM processes that can ever run at the same time.
```
pm.max_children
This value can be calculate like this :
pm.max_children = (total RAM - (500MB) )/ process memory.
```
 
To find the average process memory, you can use this command [1]:

```bash
ps -ylC php-fpm7.2 --sort:rss | awk '!/RSS/ { s+=$8 } END { printf "%s\n", "Total memory used by PHP-FPM child processes: "; printf "%dM\n", s/1024 }'
```

Why 500MB ?
Depends of what is running on your system, but you want to keep memory for nginx (about 20MB), MySql and others services.

pm.min_spare_servers and pm.max_spare_servers
Sets the desired minimum/maximum number of idle server processes (waiting to process). If the number of 'idle' processes is less/great than this number then some children will be deleted/created. These values can be optimized for CPU with a high value and for RAM with a low value.

pm.start_servers
The number of children created on startup. Value must be between pm.min_spare_servers and pm.max_spare_servers.

pm.max_requests
We want to keep it hight to prevent server respawn. Note: If you have a memory leak in your PHP code decrease this value to recreate it quickly and free the memory.

Профилирование PHP с XHprof
http://ruhighload.com/index.php/2009/08/21/xhprof-%D0%BF%D1%80%D0%BE%D1%84%D0%B8%D0%BB%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-php-%D0%BE%D1%82-facebook/
