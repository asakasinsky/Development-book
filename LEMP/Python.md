# Python 

```bash  
sudo apt-get -y install python-dev build-essential
```

## Возможные зависимости

Иногда при установке пакетов Python происходят ошибки из-за отсутствия нужных библиотек в системе. Ниже указаны библиотеки для некоторых часто используемых пакетов в Ubuntu 14.04 LTS.

```bash 
# для пакета MySQL-python
sudo apt-get -y install python-mysqldb 
# для пакета pycurl
sudo apt-get -y install libcurl4-openssl-dev 
# для пакета lxml
sudo apt-get -y install libxml2-dev libxslt1-dev 
```

```bash  
sudo apt-get update && sudo apt-get install -y curl && curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | sudo python

sudo easy_install pip

sudo pip install virtualenv
```

```bash  
mkdir -p ~/workspace/site/  
cd ~/workspace/site/  
virtualenv -p /usr/bin/python --no-site-packages ./flask  
```

Ставим нужное нам приложение, например Flask  
```bash  
. ./flask/bin/activate  
```

Если есть requirements.txt со списком пакетов, то  
```bash  
pip install -r /path/to/requirements.txt  
```

если нет, то просто  
```bash  
pip install Flask  
deactivate  
```

```bash  
mkdir -p ~/workspace/site/app  
mkdir -p ~/workspace/site/app/static  
mkdir -p ~/workspace/site/app/templates  
mkdir -p ~/workspace/site/logs  
mkdir -p ~/workspace/site/tmp  
```

```bash  
nano run.py  
```

```python  
#!flask/bin/python  
import sys  
# to load _functools  
sys.path.append('/usr/lib/python2.7/lib-dynload')  
# to load os  
sys.path.append('/usr/lib/python2.7')  
# import os

from flask import Flask

app = Flask(__name__)


@app.route('/')  
def index():
    return "Hello, World!"

if __name__ == '__main__':
    app.run(debug=True)  
```

Нелепые _sys.path.append_ вначале вызваны тем, что некоторых модулей в «чистом» виртуальном окружении нет.

----------------------------------

## Nginx

Если домен - localhost, то удаляем заглушку для дефолтного сервера  
```bash  
sudo rm /etc/nginx/sites-enabled/default  
sudo rm /etc/nginx/sites-available/default  
```

```bash  
sudo nano  /etc/nginx/sites-available/site.conf  
```

```bash  
server {
    listen       80;
    server_name  localhost;
    root /home/username/workspace/site/app;
    access_log /home/username/workspace/site/logs/access.nginx.log;
    error_log /home/username/workspace/site/logs/error.nginx.log;

    location /static {
        alias /home/username/workspace/site/app/static;
    }

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/home/username/workspace/site/tmp/site.sock;
        uwsgi_param UWSGI_PYHOME /home/username/workspace/site/flask;
        uwsgi_param UWSGI_CHDIR /home/username/workspace/site;
        uwsgi_param UWSGI_MODULE run;
        uwsgi_param UWSGI_CALLABLE app;
    }  
}
```

```bash  
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/

sudo service nginx restart  
```

----------------------------------

## uWSGI

[uWSGI docs](http://uwsgi-docs.readthedocs.org/en/latest/index.html)

uWSGI ставим в обычное, невиртуальное окружение  
sudo pip install uwsgi

```bash  
nano /home/username/workspace/site/application.ini  
```

```bash  
[uwsgi]  
uid=username  
gid=username  
chmod-socket=666  
chown-socket=username  
socket=/home/username/workspace/site/tmp/site.sock  
pidfile=/home/username/workspace/site/tmp/uwsgi.pid  
virtualenv=/home/username/workspace/site/flask  
chdir=/home/username/workspace/site  
module=run  
callable=app  
pythonpath=/home/username/workspace/site/flask/lib/python2.7/site-packages/  
no-site=True  
touch-reload=/home/username/workspace/site/run.py  
master = true  
processes = 1  
threads = 10  
enable-threads = True  
logto=/home/username/workspace/site/logs/site.uwsgi.log  
```

Теперь запускаем uWSGI:  
```bash  
uwsgi --ini /home/username/workspace/site/application.ini  
```

или запускаем uWSGI фоном:  
```bash  
uwsgi --ini /home/username/workspace/site/application.ini &  
```

Чтобы перезапустить uWSGI достаточно изменить файл /var/www/dev/site.py или "прикоснуться" (команда _touch_) к нему:

Поверка работы uWSGI (вывод процессов)  
```bash  
ps -ef|grep uwsgi  
```

Перезапуск сервера uWSGI  
```bash  
touch /var/www/dev/site.py  
```

Можно «gracefully» перезапустить послав сигнал HUP в master-процесс:  
```bash  
kill -HUP `cat /home/username/workspace/api/tmp/uwsgi.pid`  
uwsgi --reload /home/username/workspace/api/tmp/uwsgi.pid  
```

или остановить  
```bash  
kill -INT `cat /home/username/workspace/api/tmp/uwsgi.pid`  
uwsgi --stop /home/username/workspace/api/tmp/uwsgi.pid  
```

Теперь остается сделать так, чтобы uWSGI мог запускаться вместе со стартом системы. Для этого используем supervisor.  
```bash  
sudo nano /etc/supervisor/conf.d/site.conf  
```

```bash  
[program:site]  
directory=/home/username/workspace/site/  
command=uwsgi --ini /home/username/workspace/site/application.ini  
user=username  
autostart=true  
autorestart=true  
stdout_logfile=/home/username/workspace/site/logs/site.uwsgi.log  
stderr_logfile = /home/username/workspace/site/logs/site.uwsgi_err.log  
redirect_stderr=true  
stopsignal=INT  
```

Теперь запускать, останавливать или перезапускать uWSGI можно с помощью команд для supervisord. К примеру:

```bash  
/etc/init.d/supervisor start  
```

----------------------------------

## Gunicorn

Если отношения с uWSGI не сложились, можно попробовать gunicorn.  
Отличий будет не очень много, примеры тут:  

- [How to Run Flask Applications with Nginx Using Gunicorn](http://www.onurguzel.com/how-to-run-flask-applications-with-nginx-using-gunicorn/)  
- [Managing Gunicorn Processes With Supervisor](http://www.onurguzel.com/managing-gunicorn-processes-with-supervisor/)  
- [Using the 'if' statement in a location like that is considered a bad idea by the nginx people...](http://www.onurguzel.com/how-to-run-flask-applications-with-nginx-using-gunicorn/#comment-816040378)

Пример настроек nginx  
```bash  
sudo nano  /etc/nginx/sites-available/site.conf  
```

```bash  
server {
    listen       80;
    server_name  localhost;

    access_log /home/username/workspace/site/logs/access.nginx.log;
    error_log /home/username/workspace/site/logs/error.nginx.log;

    location /static {
        alias /home/username/workspace/site/app/static;
    }

    location / {
        try_files $uri @gunicorn_proxy;
    }

    location @gunicorn_proxy {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://127.0.0.1:8000;
    }  
}
```

----------------------------------

## Логи

В принципе так как логи пишуться в директории пользователя, то вполне должно хватить настроек logrotate для nginx.
