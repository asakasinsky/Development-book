# PHP

```bash  
sudo add-apt-repository ppa:ondrej/php5  
sudo apt-get update && sudo apt-get upgrade  
```

```bash  
sudo apt-get -y install php5-common php5-mysql php5-fpm sqlite php5-sqlite php5-cli php5-gd php5-curl php5-xdebug php5-imagick php5-intl php5-mcrypt php5-xmlrpc php5-memcached  php5-dev php5-xhprof
```

Проверяем версию  
```bash  
php -v  
```

Ставим по желанию PEAR и PHPUnit...  

```bash  
sudo apt-get -y install php-pear  
pear upgrade pear
 
# Как установить PECL-расширение:
# pecl install perl

# Как удалить PECL-расширение:
# pecl uninstall perl

sudo pear channel-discover pear.phpunit.de  
sudo pear channel-discover components.ez.no  
sudo pear channel-discover pear.symfony.com  
sudo pear install --alldeps phpunit/PHPUnit  
```

... или Composer (глобально, на уровне системы; команда «composer» вместо локального «php composer.phar» )
> Сейчас есть тенденция использовать Composer вместо PEAR. У меня пока нет сложившегося мнения какой менеджер лучше, замечу только что Composer устанавливает зависимости локально в проекте а не глобально на уровне всей системы

```bash
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
```


Убедимся, что php5-fpm стартует при загрузке системы  
```bash  
sudo update-rc.d php5-fpm defaults  
```

Если появится сообщение вроде этого:  
```bash  
System start/stop links for /etc/init.d/php5-fpm already exist.  
```

значит php5-fpm настроен на запуск при загрузке

Подобным образом можно отключить автозапуск  
```bash  
sudo update-rc.d php5-fpm remove  
```

Управление php5-fpm  
```bash  
sudo service php5-fpm {start|stop|restart|status}  
```  
Поверка работы php5-fpm (вывод процессов)  
```bash  
ps -ef|grep php-fpm  
```


Как найти загруженную конфигурацию php-fpm
php5-fpm -i | grep php.ini
Как найти загруженную конфигурацию php-cli
php5 -i | grep php.ini

====================
```bash  
pm.max_children = 100
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 15
pm.max_requests = 1000
```


The configuration variable pm.max_children controls the maximum amount of FPM processes that can ever run at the same time.

pm.max_children
This value can be calculate like this :
pm.max_children = total RAM - (500MB) / process memory.

To find the average process memory, you can use this command [1]:

```bash  
ps -ylC php5-fpm --sort:rss | awk '!/RSS/ { s+=$8 } END { printf "%s\n", "Total memory used by PHP-FPM child processes: "; printf "%dM\n", s/1024 }'
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

