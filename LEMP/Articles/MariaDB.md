## MariaDB

MariaDB прозрачно заменяет MySQL

[Здесь](https://downloads.mariadb.org/mariadb/repositories/) можно подсмотреть репозиторий для текущей версии ОС.

[Здесь](https://tools.percona.com/wizard) есть великолепный инструмент для генерирования настроек. Он спас мне мое время.

Добавим репозиторий для Ubuntu 14.01 Trusty
```bash
sudo apt-get install python-software-properties
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com CBCB082A1BB943DB
sudo add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu trusty main'
```

```bash
sudo apt-get update
sudo apt-get install mariadb-server mariadb-client libmariadbclient-dev mysqltuner
```

```bash  
mysql_secure_installation  
```

Разрешаем удалённое подключение  
_Впрочем для подключения посредством SSH-тоннеля делать это совсем необязательно_

Убедимся, что MariaDB стартует при загрузке системы  
```bash  
sudo update-rc.d mysql defaults  
```

Если появится сообщение вроде этого:  
```bash  
System start/stop links for /etc/init.d/mysql already exist.  
```

значит MariaDB настроена на запуск при загрузке

Подобным образом можно отключить автозапуск  
```bash  
sudo update-rc.d mysql remove  
```

Управление MariaDB  
```bash  
sudo service mysql {start|stop|restart|reload|force-reload|status}  
```
