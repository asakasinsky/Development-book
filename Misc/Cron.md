## Cron

Синтаксис постановки задачи
[минута][час][день][месяц][неделя][пользователь][команда]

* * * * * выполняемая команда
- - - - -
| | | | |
| | | | ----- День недели (0 - 7) (Воскресенье =0 или =7)
| | | ------- Месяц (1 - 12)
| | --------- День (1 - 31)
| ----------- Час (0 - 23)
------------- Минута (0 - 59)

Избежать запуска задачи пока не закончился предыдущий запуск
```bash
* * * * flock -n /tmp/path.to.lockfile -c command with args
```

```bash
* * * * * /usr/bin/flock -n /tmp/fcj.lockfile /usr/local/bin/frequent_cron_job --minutely
```


/etc/cron.d/*
Выполняются от имени root
* * * * task args
/etc/cron.daily/*
/etc/cron.hourly/*
/etc/cron.monthly/*
/etc/cron.weekly/*

Тут можно указать от какого пользователя запускать задачу
* * * * username task args
/etc/crontab

Пользовательские crontab лежат тут
/var/spool/cron/crontabs

Бэкап кронтаба
crontab -l > my-crontab
Инсталл задач из бэкапа
crontab my-crontab

