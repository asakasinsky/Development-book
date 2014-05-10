ps -ef|grep php-fpm  


Check version  
```bash  
lsb_release -a  
```bash

Check free disk space  
```bash  
df -h /  
```

Check free memory  
```bash  
grep MemTotal /proc/meminfo  
```

or  
```bash  
free -m  
```

service named configtest

В системе есть swap раздел? Он используется?
CODE: SELECT ALL
free -m

Какая нагрузка 
CODE: SELECT ALL
top -b |head -n5


---------------------------------------------

Для оптимизации mysql существует простая и удобная в использовании утилита [mysqltuner.pl](https://raw.github.com/major/MySQLTuner-perl/master/mysqltuner.pl)

[tuning-primer.sh](https://launchpadlibrarian.net/78745738/tuning-primer.sh)

Ещё рекомендую утилиту для mysql для выявления медленных запросов: [mysqlsla](http://hackmysql.com/mysqlsla). Она умеет анализировать slow-логи (да и обычные логи) и показывать различную статистику. Причём утилита достаточно умная и умеет собирать вместе запросы, которые различаются только параметрами.

---------------------------------------------


Posts: 96
Joined: Fri Jan 25, 2013 8:04 am
Location: Kiev
Re: MySQL падает
PostThu Aug 29, 2013 7:24 pm

Привет снова. Нашел частичное решение данного трабла.
Нужен своп! :)
CODE: SELECT ALL
dd if=/dev/zero of=/swapfile bs=1M count=1024
mkswap /swapfile
swapon /swapfile
В файл /etc/fstab добавляем строку
CODE: SELECT ALL
/swapfile swap swap defaults 0 0


---------------------------------------------

[Есть ли стресс-тест сервисы для оценки хостинг-площадки?](http://toster.ru/q/5046?_aa=press_anykey)

---------------------------------------------

Сейчас вот прогнал ab
ab -t30 -c5 http://sg.wmail.tk:80/

---------------------------------------------

Cloud-Flare

---------------------------------------------

Чтобы не отваливался MySQL - Нужно создать swap

---------------------------------------------

38 единовременных подключений для minimal инстанции, это нормальный результат. Для существенного увеличения этого числа нужно использовать статическое кэширование в приложении. Добиться более высоких результатов за счет настройки httpd не получится. В условиях ограниченного кол-ва оперативной памяти, memcache будет малополезен. Для wordpress есть плагины вроде W3 Total Cache.

---------------------------------------------

Победил ошибку c Mysql при зажатом F5

При частом рефреше страницы nginx все запросы передает Apache, а апач на каждый новый запрос создает новый процесс, так как работает в режиме Prefork, соответственно каждый новый процесс съедает часть памяти, но кроме того, эти процессы начинают выполняться, в результате количество запросов к Mysql превышает число max_user_connections.

Для того, чтобы запретить nginx передавать в апач множественные запросы от отдного пользователя нужно файле /etc/nginx/nginx.conf в секции http прописать

limit_req_zone $binary_remote_addr zone=dyn:10m rate=10r/s;

Эта директива ограничивает количество запросов от одного клиента до 10 запросов в секунду

И в файле /home/username/conf/web/nginx.conf 
во-первых выносим обработку статики отдельно: 

location ~* ^.+\.(jpg|jpeg|gif|png|ico|svg|css|zip|tgz|gz|rar|bz2|exe|pdf|doc|xls|ppt|txt|odt|ods|odp|odf|tar|bmp|rtf|js|mp3|avi|mpeg|flv|html|htm)$ {

root /home/UserName/web/site.com/public_html;
access_log /var/log/httpd/domains/site.com.log combined;
access_log /var/log/httpd/domains/site.com.bytes bytes;
expires max;
try_files $uri @fallback;
}

А в данных передающихся апачу дописываем вызов директивы limit_req

location / {
limit_req zone=dyn burst=10;
proxy_pass http://ip:8080;
}

это позволит ограничить до 10 одновременных запросов к апачу от одного клиента, при привышении nginx будет отдавать для этого клиента ошибку 503, работа других клиентов нарушена не будет. 
При желании 503 ошибку можно завернуть так, что клиент ее не увидит.

Тестировалось у DigitalOcean на сервере с 512Mb.

---------------------------------------------

[Защита от DDoS & F5 – Apache + Nginx](http://hooked-hands.ru/2014/02/142/)

---------------------------------------------

touch /var/log/mysql/log-slow-queries.log

---------------------------------------------

[How to Check and Repair MySQL Tables Using Mysqlcheck](http://www.thegeekstuff.com/2011/12/mysqlcheck/)

---------------------------------------------

http://www.narga.net/optimizing-apachephpmysql-low-memory-server/

---------------------------------------------

http://ewan.im/900/10-million-hits-a-day-with-wordpress-using-a-15-server

---------------------------------------------

http://habrahabr.ru/post/198982/

---------------------------------------------

http://habrahabr.ru/post/176119/

---------------------------------------------

http://www.mysqlcalculator.com/

---------------------------------------------

Мускуль падает, скорее всего, от нехватки оперативки. Нужно потюнить. За образец для начала можно взять вот это (такой конфиг на моем экспериментальном дроплете в 512Mb):
[client]
port        = 3306
socket      = /var/run/mysqld/mysqld.sock
[mysqld_safe]
socket      = /var/run/mysqld/mysqld.sock
nice        = 0
[mysqld]
user        = mysql
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
port        = 3306
basedir     = /usr
datadir     = /var/lib/mysql
tmpdir      = /tmp
lc-messages-dir = /usr/share/mysql
skip-external-locking
local-infile=0
bind-address        = 127.0.0.1
key_buffer      = 16M
max_allowed_packet  = 16M
thread_stack        = 192K
thread_cache_size       = 8
myisam-recover         = BACKUP
query_cache_limit   = 1M
query_cache_size        = 16M
log_error = /var/log/mysql/error.log
expire_logs_days    = 10
max_binlog_size         = 100M
[mysqldump]
quick
quote-names
max_allowed_packet  = 16M
[mysql]
[isamchk]
key_buffer      = 16M
!includedir /etc/mysql/conf.d/


+ для стабильности лучше создать swapfile

Ну а дальше - стандартные процедуры:
1) ставить сервер на мониторинг (если попроще, то munin/monitorix)
2) нагружать
3) смотреть логи и в мониторинг
4) тюнить конфиги сервисов и CMS
5) GOTO 2 вплоть до достижения приемлемого результата.

А из онлайн-сервисов нагружать лучше при помощи blitz.io (если речь про бесплатные версии), он в "бесплатном" варианте генерирует нагрузку посерьезнее, чем loadimpact.

--------------------------------------------

http://habrahabr.ru/post/41166/

--------------------------------------------

