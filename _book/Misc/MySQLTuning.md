## «Доводка» Mysql

### 2. Mysqlcheck

[How to Check and Repair MySQL Tables Using Mysqlcheck](http://www.thegeekstuff.com/2011/12/mysqlcheck/)

### 3. Slow log 

add in my.cnf

```bash
# Включаем запись медленных запросов
slow_query_log=1
# файл лога медленных запросов
slow_query_log_file     = /var/log/mysql/log-slow-queries.log
# максимальное количество секунд, которое может выполняться запрос, прежде чем он будет записан в лог медленных запросов
long_query_time = 1


# будут записываться запросы, которые не используют индексы
# log-queries-not-using-indexes

# Записывать в лог медленные административные операторы такие, как OPTIMIZE TABLE, ANALYZE TABLE, и ALTER TABLE.
# log-slow-admin-statements
```

and restart MySQL:
sudo service mysql restart

Примечание: кэшированные запросы не будут записываться в лог. Также не будут записываться запросы, в которых индекс не приносит пользы из-за того, что в таблице ноль или одна запись.

Вы можете столкнуться с ситуацией, когда запрос выполняется медленно только при определенных условиях (когда вы записываете его в лог), но при ручном запуске запрос отрабатывает нормально:
Таблица может быть заблокирована (locked), ставя, таким образом, запрос в очередь ожидания. В таком случае lock_time определяет, когда таблица будет разблокирована, и как долго будет обрабатываться запрос.
Данные и индексы не были занесены в кэш памяти. Это обычно случается, когда MySQL запускается в первый раз, или когда таблицы не были оптимизированы.
Был запущен сторонний процесс, замедляющий работу диска.
Сервер перегружен другими запросами в это время, и не хватает ресурсов CPU для эффективной работы.





#### Анализ с помощью percona-toolkit

sudo apt-get install percona-toolkit

./pt-query-digest /var/log/mysql/log-slow-queries.log > slow.txt

#### [Percona-toolkit GUI](https://github.com/box/Anemometer/blob/master/README.md)

git clone git://github.com/box/Anemometer.git anemometer
cd anemometer

mysql -h 127.0.0.1 -u root -pPASSWORD < install.sql
mysql -h 127.0.0.1 -u root -pPASSWORD -e "grant ALL ON slow_query_log.* to 'anemometer'@'%' IDENTIFIED BY 'superSecurePass';"

Put some data in the DB


pt-query-digest --user=anemometer --password=superSecurePass \
--review h=127.0.0.1,D=slow_query_log,t=global_query_review \
--review-history h=127.0.0.1,D=slow_query_log,t=global_query_review_history \
--no-report --limit=0% \
--filter=" \$event->{Bytes} = length(\$event->{arg}) and \$event->{hostname}=\"$HOSTNAME\"" \
/var/log/mysql/log-slow-queries.log
