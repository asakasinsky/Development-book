UFW (Uncomplicated firewall - "незамысловатый" брэндмауер)
===================

> ufw создан для упрощения работы с iptables, утилитой для управления сетевым фильтром netfilter.

Установка
```bash
sudo apt-get install ufw
```

Управление экраном
```bash
sudo ufw {enable|disable|status}
```

Изменение дефолтной политики:
```bash
# Пакеты будут заблокированы кроме пакетов имеющих разрешающее правило
ufw default deny incoming

# Пакеты будут разрешены кроме пакетов имеющих запрещающее правило
ufw default allow outgoing
```

Посмотреть все правила всех цепочек iptables:
```bash
iptables -L
```

Удалить все правила всех цепочек iptables:
```bash
iptables -F
```

Команды управления правилами:
```txt
allow - разрешить
deny - запретить
reject - запретить и отбить (дать понять что порт закрыт)
limit - ограничить|заблокировать, если с одного IP в течении 30 секунд было минимум 6 попыток соединения
delete - удалить добавленное ранее правило
insert - вставить правило в определенную позицию в цепочке
```

Протестировать правило
```bash
ufw --dry-run allow rule
```

Подробный статус
```bash
ufw status verbose
```

## Профили приложений

Посмотреть доступные профили приложений:
```bash
sudo ufw app list
>> Доступные приложения:
   OpenSSH
```

Применить профиль приложения
```bash
sudo ufw allow 'OpenSSH'
```

Все профили хранятся в директории /etc/ufw/applications.d и являются текстовыми файлами, их можно редактировать, создавать, удалять

Примеры тут [http://www.opennet.ru/openforum/vsluhforumID3/63992.html](http://www.opennet.ru/openforum/vsluhforumID3/63992.html)

Можно, например в скриптах обращаться к экрану
```bash
actionban = ufw insert 2 deny from <ip> to any app "Nginx Full"
actionunban = ufw delete deny from <ip> to any app "Nginx Full"
```

## Применение полученных знаний

```bash
sudo apt-get install ufw
sudo ufw logging on
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit "OpenSSH"
sudo ufw allow smtp
sudo ufw disable
sudo ufw enable
```


## Нерешенные вопросы

1. Нужно ли iptables-persistent
2. Узнать какое время блокировки
3. вывод забаненных IP


## Ссылки

[Rate limit HTTP requests using UFW ](https://gist.github.com/lavoiesl/3740917)
