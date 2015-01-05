## MySQL

```bash  
sudo apt-get -y install mysql-server mysql-common mysqltuner libmysqlclient-dev  
```

```bash  
mysql_secure_installation  
```

Разрешаем удалённое подключение  
_Впрочем для подключения посредством SSH-тоннеля делать это совсем необязательно_

Убедимся, что mysql стартует при загрузке системы  
```bash  
sudo update-rc.d mysql defaults  
```

Если появится сообщение вроде этого:  
```bash  
System start/stop links for /etc/init.d/mysql already exist.  
```

значит mysql настроена на запуск при загрузке

Подобным образом можно отключить автозапуск  
```bash  
sudo update-rc.d mysql remove  
```

Управление mysql  
```bash  
sudo service mysql {start|stop|restart|reload|force-reload|status}  
```


Где хранится файл настроек?
mysql --help | grep "Default options" -A 1
>> Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/etc/my.cnf ~/.my.cnf

Сюда можно положить дополнительные настройки
#
# * IMPORTANT: Additional settings that can override those from this file!
#   The files must end with '.cnf', otherwise they'll be ignored.
#
!includedir /etc/mysql/conf.d/
