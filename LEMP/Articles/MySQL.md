## MySQL 8

```sh
sudo apt install mysql-server mysql-client mysql-common libmysqlclient21
```

```sh
mysql -V
> mysql  Ver 8.0.23-0ubuntu0.20.04.1 for Linux on x86_64 ((Ubuntu))
```


```bash  
mysql_secure_installation  
# Validate pass - N
# Change pass for root - n
# Anonym users - y
# Remote root access - y
# Test tables - y
# Reload privilige - y

```

Управление mysql 
```bash  
systemctl {start|stop|restart|status} mysql 
```

```
mysqladmin -u root -p version

mysql -u root -p
```


## Настройки

#### % Host для пользователя
```sql
UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '<PASSWORD>';
FLUSH PRIVILEGES;
```

#### Где хранится файл настроек?
mysql --help | grep "Default options" -A 1
>> Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/etc/my.cnf ~/.my.cnf

#### Тест настроек
As of MySQL 8.0.16, MySQL Server supports a --validate-config option that enables the startup configuration to be checked for problems without running the server in normal operational mode:
```sh
mysqld --validate-config
```



Добавить в my.cnf (секция [mysqld])
Значения устанавить под свои нужды
```
[mysqld]
skip-name-resolve
connect-timeout                 = 6000

general_log_file                = /var/log/mysql/mysql.log
general_log                     = 0

log_queries_not_using_indexes   = 0;
long_query_time                 = 2
slow_query_log_file             = /var/log/mysql/slow.log
slow_query_log                  = 0
```


####  mysql_native_password
It is not recommended to use the mysql_native_password authentication plugin for new installations that require high password security. 
Добавить в my.cnf (секция [mysqld])
```
[mysqld]
...
default_authentication_plugin   = mysql_native_password
```


####  Лимиты max_open_files
```sh
sudo mkdir /etc/systemd/system/mysqld.service.d

sudo cat << EOF > /etc/systemd/system/mysqld.service.d/limit.conf
[Service]
LimitNOFILE=65535
EOF

sudo systemctl daemon-reload
sudo systemctl restart mysql
```


#### Закрываем извне 
если результат netstat даёт «:::*»
```sh
sudo netstat -ltunp | grep -e 3306
> tcp6       0      0 :::33060                :::*                    LISTEN      1349/mysqld
> tcp6       0      0 :::3306                 :::*                    LISTEN      1349/mysqld
```

то добавить в my.cnf (секция [mysqld])
```
bind-address                          = 127.0.0.1
mysqlx_bind_address                   = 127.0.0.1
```


Настройка MySQL
https://www.hostcms.ru/documentation/server/mysql/
Настройка MySQL: часто встречающиеся ошибки
https://netpoint-dc.com/blog/mysql-chastie-oshibki-nastroiki/

101 Tips to MySQL Tuning and Optimization
https://www.monitis.com/blog/101-tips-to-mysql-tuning-and-optimization/
MySQL Performance Cheat Sheet | Severalnines
https://severalnines.com/database-blog/mysql-performance-cheat-sheet
How to optimize MySQL 8 servers and clients | Packt Hub
https://hub.packtpub.com/optimize-mysql-8-servers-clients/

