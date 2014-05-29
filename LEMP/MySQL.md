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
