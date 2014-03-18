## Nginx

Добавим репозиторий NGINX:  
```bash  
sudo add-apt-repository ppa:nginx/stable  
sudo apt-get update && sudo apt-get upgrade  
sudo apt-get -y install nginx  
```

Убедимся, что nginx стартует при загрузке системы  
```bash  
sudo update-rc.d nginx defaults  
```

Если появится сообщение вроде этого:  
```bash  
System start/stop links for /etc/init.d/nginx already exist.  
```  
значит nginx настроен на запуск при загрузке

Подобным образом можно отключить автозапуск  
```bash  
sudo update-rc.d nginx remove  
```

Управление nginx'ом  
```bash  
sudo service nginx {start|stop|restart|reload|force-reload|status|configtest}  
```

## Выдаём заглушку для дефолтного сервера

```bash  
sudo -s  
cat /dev/null > /etc/nginx/sites-available/default  
```

```bash  
nano /etc/nginx/sites-available/default  
server {
    listen       80 default_server;
    server_name  _ ;
    root /var/www/placeholder ; 
    index index.html;  
}
```

```bash  
mkdir -p /var/www/placeholder  
```

Создаём пустой индексный файл в /var/www/placeholder  
```bash  
cat /dev/null > /var/www/placeholder/index.html  
```

**ИЛИ**  
Возможно покажется полезным вставить имя сервера в индексный файл.  
Так как обычно серверов бывает больше одного, то каждому из них присваивается название. В каждой компании это происходит по-разному, но очевидных способов - три:

1. от балды  
2. мнемонический, зависит от функциональности, пример: backup-1, www_1, db_main  
3. творческий, по именам городов, рек, мифологических героев, богов, планет, звёзд и т.д

Я считаю, что третий способ самый клёвый, он даёт возможность дать красивые, запоминающиеся имена серверам и узнать что-то новое. На данный момент для своих личных серверов я использую названия инертных газов и потому смог запомнить что их всего шесть и названия их: гелий, неон, аргон, криптон, ксенон, радон.

Данный способ еще может быть полезен при использовании сервиса мониторинга.

Вместо {server_name} вставляем имя, например — neon  
Вместо {monitoring_script} вставляем код скрипта мониторинга, например — Яндекс.Метрика или New Relic

```bash  
nano /var/www/placeholder/index.html  
```

```html  
<!DOCTYPE html>  
<html>  
<head>  
<title>{server_name}</title>  
</head>  
<body>  
{server_name} - <b>OK</b>  
{monitoring_script}  
</body>  
</html>

```

```bash  
service nginx restart  
exit  
```
