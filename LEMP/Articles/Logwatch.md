Logwatch
==========

## Подготовка

```bash
sudo apt-get install logwatch
mkdir -p /var/cache/logwatch

ls -l /usr/share/logwatch/scripts/services
```

## Настройка

Откроем:
```bash
sudo nano /usr/share/logwatch/default.conf/logwatch.conf
```

Добавим в конец
```txt
LogDir = /var/log
TmpDir = /var/cache/logwatch
Archives = Yes
Range = Yesterday
Mailer = "/usr/sbin/sendmail -t"

Output = Mail
MailTo = admin@site.ru
MailFrom = logwatch@site.ru
Detail = High
Format = Html

# Service = All

Service = sshd
Service = iptables
Service = nginx
Service = cron
Service = sudo
Service = pam_unix
Service = postfix

Service = zz-disk_space
```


## Тест

```bash
logwatch --output stdout --format text --range Today
```


# Добавим логи Nginx под мониторинг

```bash
cp /usr/share/logwatch/scripts/services/http /etc/logwatch/scripts/services/nginx
cp /usr/share/logwatch/scripts/services/http-error /etc/logwatch/scripts/services/nginx-error

cp /usr/share/logwatch/default.conf/services/http.conf /etc/logwatch/conf/services/nginx.conf
```

Откроем:
```bash
nano /etc/logwatch/conf/services/nginx.conf
```

Заменим названия:
```bash
Title = "nginx"
# Which logfile group...
LogFile = nginx
```


```bash
cp /usr/share/logwatch/default.conf/services/http-error.conf /etc/logwatch/conf/services/nginx-error.conf
```

Откроем:
```bash
nano /etc/logwatch/conf/services/nginx-error.conf
```

Заменим:
```bash
Title = http errors
# Which logfile group...
LogFile = http-error
```

Откроем:
```bash
nano /etc/logwatch/conf/logfiles/nginx.conf
```

Заменим:
```bash
LogFile = /home/<username>/logs/nginx.access.log
Archive = /home/<username>/logs/nginx.access.log*.gz

*ExpandRepeats

# keep only the lines in the proper date range
*ApplyhttpDate
```

Откроем:
```bash
nano /etc/logwatch/conf/logfiles/nginx-error.conf
```

Заменим:
```bash
LogFile = /home/<username>/logs/nginx.error.log
Archive = /home/<username>/logs/nginx.error.log-*.gz

# expand the repeats
*ExpandRepeats

# keep only the lines in the proper date range
*ApplyhttpDate
```

По этому приципу можно создать и остальные обработчики

Проверим работу
```bash
logwatch
```
Если есть ошибки то исправляем.

Если нужно, то можно поправить работу по расписанию:
```bash
nano /etc/cron.daily/00logwatch
```

образец команды:
```bash
/usr/sbin/logwatch --output mail --mailto test@example.com --detail high
```
