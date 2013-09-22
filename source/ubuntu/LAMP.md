диск 8.6 Гб

7.8 Гб - /

803.2 MB - swap
 
при установке пакетов отмечаем только openssh

--------------

ssh.md

---------------

Ставим нужные пакеты
sudo apt-get install curl unzip mc htop git
sudo apt-get install apache2

sudo apt-get install mysql-server mysql-client
mysql_secure_installation
sudo apt-get install php5 php5-mysql php5-suhosin php-pear php5-curl php5-gd php5-imagick php5-mcrypt php5-memcache php5-xdebug php-apc php5-imap php5-mhash php5-ming php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl  phpmyadmin

pear upgrade pear
 
# PHPUnit
pear channel-discover pear.phpunit.de
pear channel-discover components.ez.no
pear channel-discover pear.symfony.com
 
pear install --alldeps phpunit/PHPUnit



sudo a2enmod ssl && sudo a2enmod rewrite && sudo a2enmod suexec && sudo a2enmod include  && sudo a2enmod status && sudo a2enmod info && sudo a2enmod expires && sudo a2enmod headers 
sudo /etc/init.d/apache2 restart  



sudo nano  /etc/apache2/apache2.conf
User: xxx  
Group: xxx  

sudo nano /etc/apache2/apache2.conf
Добавить строку
ServerName localhost:80

Создаём ссылку на конфигурационный файл виртуальных хостов
sudo ln -s  ~/Workspace/vhost /etc/apache2/sites-available/default 


Примерное содержимое этого файла
<Location /server-status>
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from localhost 192.168.56.1
</Location>

<VirtualHost _default_:80>
    ServerName localhost
    DocumentRoot /home/developer/Workspace/
</VirtualHost>


<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /home/developer/Workspace/localhost.dev/htdocs
    ServerName localhost.dev
    ErrorLog /home/developer/Workspace/localhost.dev/error.log
    CustomLog /home/developer/Workspace/localhost.dev/access.log combined
    <Directory /home/developer/Workspace/localhost.dev>
        Allow from all
    </Directory>
</VirtualHost>

/etc/php5/apache2/php.ini https://gist.github.com/4611263

«Мягко» перезагружаем сервер
sudo apache2ctl graceful


Если ошибка, то смотрим логи:
/var/log/apache2/error.log
