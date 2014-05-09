# PHP

```bash  
sudo add-apt-repository ppa:ondrej/php5  
sudo apt-get update  
sudo apt-get upgrade  
```

```bash  
sudo apt-get -y install  php5-common php5-mysql php5-fpm sqlite php5-sqlite php5-cli php5-gd php5-curl php5-xdebug php-apc php5-imagick php5-intl php5-mcrypt php5-xmlrpc php5-memcached  
```

Проверяем версию  
```bash  
php -v  
```

Ставим по желанию PEAR и PHPUnit...  

```bash  
sudo apt-get -y install php-pear  
pear upgrade pear
 
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
