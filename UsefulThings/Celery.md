# Celery

## Установка

```bash 
pip install celery
sudo apt-get install rabbitmq-server
```


## Настройка брокера заданий

По умолчанию celery соединяется с rabbitmq используя гостевой доступ. Исправим это:
```bash
sudo rabbitmqctl add_vhost <host>
sudo rabbitmqctl add_user <username> <password>
sudo rabbitmqctl set_permissions -p <host> <username> ".*" ".*" ".*"
sudo rabbitmqctl set_user_tags <username> management
```


## Хранение результатов

В качестве хранилища состояний задач и результатов их выполнения можно использовать как RabbitMQ так и SQL-сервер. В конкретном примере будем использовать MySQL. Сначала создадим базу данных celery и одноимённого пользователя c помощью обычной MySQL консоли.

```bash
CREATE DATABASE IF NOT EXISTS `celery` CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON `celery`.* To 'celery'@'127.0.0.1' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```


## Конфигурация celery
Теперь в конфигурации celery нужно указать:
```python
BROKER_URL = "amqp://<username>:<password>@localhost:5672/<host>"
```

Кстати, пример конфигурации:
```python
# coding: utf-8
# File: __init__.py
from celery import Celery
from celery.task.schedules import crontab
from celery.decorators import periodic_task
from celery.decorators import task
# Импортируем файл с задачами
import celerytasks

db_string = "db+mysql://%s:%s@%s/%s" %\
            ('<username>', '<password>', '127.0.0.1', '<database>')

# Создаём экземпляр celery, в конструкторе указываем настройки…
app = Celery('tasks', backend='amqp', broker='amqp://')

# … или указываем здесь
app.conf.update(
    BROKER_URL='amqp://<username>:<password>@localhost:5672/<host>',
    CELERY_TASK_SERIALIZER='json',
    CELERY_ACCEPT_CONTENT=['json'],  # Ignore other content
    CELERY_RESULT_SERIALIZER='json',
    CELERY_TASK_RESULT_EXPIRES=None,
    CELERY_TIMEZONE='Europe/Moscow',
    CELERY_ENABLE_UTC=True,
    CELERY_SEND_TASK_ERROR_EMAILS=True,
    ADMINS=(('admin', 'admin@example.com')),

    # echo enables verbose logging from SQLAlchemy.
    CELERY_RESULT_ENGINE_OPTIONS = {
        'echo': True
    },

    ## Using the database to store task state and results.
    CELERY_RESULT_BACKEND=db_string,
    # CELERY_RESULT_BACKEND='amqp',
    CELERYD_USER="<username>",
    CELERYD_GROUP="<username>",
    # CELERYD_LOG_FILE="/home/<username>/log/celery/%N.log",
    # CELERYD_PID_FILE="/home/<username>/run/celery/%N.pid"
)

@periodic_task(
    name='tasks.starter'
    run_every=crontab(minute="*/15"),
    ignore_result=False
)
def starter():
    # Read this http://celery.readthedocs.org/en/latest/userguide/tasks.html#tips-and-best-practices about chaning
    # fetch_page -> parse_page -> store_page
    chain = fetch_page.s() | parse_page.s() | store_page.s()
    chain()


@task(name='tasks.fetch_page')
def fetch_page():
    return celerytasks.fetch_page()


@task(name='tasks.store_page')
def parse_page(params=None):
    return celerytasks.parse_page(params)


@task(name='tasks.fetch_page')
def store_page(params=None):
    return celerytasks.store_page(params)
```


## Пример задачи

Создаём папку пакета задач:
```bash
mkdir -p /home/<username>/tasks
```

В папке _/home/<username>/tasks_ помещаем файл <code>__init__.py</code>, распечатанный выше. Рядом помещаем файл <code>celerytasks.py</code>:
```python
# coding: utf-8
def fetch_page(params=None):
    print 'fetch_page completed'
    return (2*2)

def store_page(params=None):
    print 'store_page completed'
    return (2*2)

def store_page(params=None):
    print 'store_page completed'
    return (2*2)
```


## Запуск celery 


Создаём папку управляющих скриптов:
```bash
mkdir -p /home/<username>/workspace
```


Скрипт запуска:
```bash
# /home/<username>/workspace/start_tasks.sh
#!/bin/bash

# Absolute path to this script
# directory with the tasks module there
TASKS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $TASKS_PATH
$TASKS_PATH/config/development/env/bin/celery worker -A tasks -B  --loglevel=DEBUG &
```


Скрипт остановки:
```bash
# /home/<username>/workspace/stop_tasks.sh
#!/bin/bash
# Usage:
# ./stop_tasks.sh
# Процесс закончит текущую задачу перед завершением. Если же вы хотите закрыть
# процессы не дожидаясь окончания выполнения задачи,
# то воспользуйтесь следующей командой:
# ./stop_tasks.sh immediatly

IMMEDIATLY=''
if [ "$1" = "immediatly" ]; then
        IMMEDIATLY='-9'
fi
ps auxww | grep 'celery worker' | awk '{print $2}' | xargs kill $IMMEDIATLY

```


Убедиться что rabbitmq запущен можно так:
```bash
ps aux | grep rabbit --color
```


Убедиться что celery запущен можно так:
```bash
ps aux | grep celery --color
```

Думаю, как использовать это, вопросов не возникнет. 


## Автозапуск

Автозапуск можно обеспечить если записать в <code>/etc/rc.local</code> перед <code>exit 0</code>:
```bash
sleep 3s; sh '/home/<username>/workspace/start_tasks.sh'
```


## Автозапуск с помощью supervisor

Создаём папку для хранения логов:
```bash
mkdir -p /home/<username>/workspace/logs
```


Создадим конфигурационный файл:
```bash
nano /home/<username>/workspace/supervisor.conf
```

```bash
[program:celery]
command=/home/<username>/workspace/config/development/env/bin/celery  worker -A tasks -B --loglevel=DEBUG
directory=/home/<username>/workspace
environment=PATH="/home/<username>/workspace/config/development/env/bin"

; If supervisord is run as root, we could subprocess with another user
user=<username>
; Logs path
stdout_logfile=/home/<username>/workspace/logs/celeryd.log
stderr_logfile=/home/<username>/workspace/logs/celeryd.error.log

autostart=true
autorestart=true
startsecs=10
; Need to wait for currently executing tasks to finish at shutdown.
; Increase this if you have very long running tasks.
stopwaitsecs = 30
killasgroup=true
stopasgroup=true
; if rabbitmq is supervised, set its priority higher
; so it starts first
priority=998
stopsignal=INT
```


```bash
sudo ln -s /home/<username>/workspace/supervisor.conf /etc/supervisor/conf.d/<username>.conf
```

Обновим конфигурацию:
```bash
sudo supervisorctl reread
sudo supervisorctl update
```

Можем проверить статус:
```bash
sudo supervisorctl status
```

А вот так можем управлять нашей задачей:
```bash
sudo supervisorctl start celery 
sudo supervisorctl stop celery
```


Или всеми задачами:
```bash
sudo supervisorctl start all
sudo supervisorctl stop all
```


## Позаботимся о логах

Логи имеют свойство разрастаться. Особенно в отладочном режиме, вспомните что мы запускаем celery с ключом <code>--loglevel=DEBUG</code>. Поэтому добавим информацию о расположении log-файлов проекта в logrotate:

```bash
nano /home/<username>/workspace/logrotate.conf
```

```bash
/home/<username>/workspace/logs/*.log {
    weekly
    rotate 52
    compress
    delaycompress
    notifempty
    missingok
    copytruncate
}
```


```bash
sudo ln -s /home/<username>/workspace/logrotate.conf /etc/logrotate.d/<username>
```
