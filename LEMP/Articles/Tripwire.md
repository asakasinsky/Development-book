Tripwire
===========

## Установка

```bash
sudo apt-get update
sudo apt-get install tripwire
```

## Ссылки 

Основной источник: [How To Use Tripwire to Detect Server Intrusions on an Ubuntu VPS | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-tripwire-to-detect-server-intrusions-on-an-ubuntu-vps)  

[Checking System Integrity with tripwire - O'Reilly Media](http://www.onlamp.com/pub/a/bsd/2003/03/20/freebsd_basics.html)

[Bog BOS: Tripwire: принципы работы, установка и настройка](http://www.bog.pp.ru/work/tripwire.html)


## Расписание

```bash
crontab -e

# Добавить:
30 3 * * * /usr/sbin/tripwire --check | /usr/sbin/sendmail -t test@example.com
```


## Зафиксировать изменения

```bash
sudo tripwire --check --interactive
```
