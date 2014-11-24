## Полезные сервисы

[Проверка Reverse DNS lookup](http://remote.12dt.com/)

[Проверка Reverse DNS lookup](http://mxtoolbox.com/ReverseLookup.aspx)

[Проверка DNS записи DKIM](http://dkimcore.org/tools/dkimrecordcheck.html)

[DomainKeys, DKIM, SPF, SpamAssassin Email валидатор](http://www.brandonchecketts.com/emailtest.php)

[SUPERTOOL](http://mxtoolbox.com/SuperTool.aspx)


## Полезные ссылки

[Настройка POSTFIX](http://www.maxblogs.ru/articles/nastroika-postfix)


## Postfix — сервер MTA (англ. mail transfer agent)

Установка:
```bash
sudo apt-get install postfix
```

Выбираем «Internet Site» и затем вводим доменное имя, закреплённое за сервером. Далее Postfix автоматически установится. Останется небольшой штрих:

```bash
sudo nano /etc/postfix/main.cf
```

Пишем доменное имя:
```bash
myhostname = example.com
```

Правим строку с ключом _mydestination_, отвечающим за список доменов которые будет обслуживать Postfix. В нашем случае тут останется только домен, localhost.localdomain и localhost:
```bash
mydestination = example.com, localhost.localdomain, localhost
```

Ключ _relayhost_ оставляем пустым. Убедитесь, что ключ _mynetworks_ содержат эту запись.

```bash
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
```

Ключ указывает на то, кто может отправлять почту с данного сервера. Этой записью мы разрешаем слать письма только с локальных адресов.

Перезагружаем MTA:
```bash
sudo service postfix reload
```


## Mail-Forwarding

Внесём изменения в DNS-записи:

- создадим A-запись: 
    - название — mail
    - IP — IP сервера, тот, что указан в основной A-записи
- создадим MX-запись: 
    - имя хоста: mail.example.com. (с точкой на конце, меняем на свой домен)
    - приоритет: 5

![На примере DigitalOcean.com](../images/digitalocean-DNS.png)

Откроем файл конфигурации Postfix:
```bash
sudo nano /etc/postfix/main.cf
```

заменим ключ alias_maps на:
```bash
virtual_alias_maps = hash:/etc/postfix/virtual
```

Добавим дополнительный e-mail, для этого заведём файл содержащий алиасы:
```bash
sudo nano /etc/postfix/virtual
```

Пример алиасов:
```bash
info@example.com username
# где username - имя пользователя в системе
# вся почта будет тут: /var/mail/username

# или перенаправим почту на другой домен
info@example.com username@gmail.com

# или на несколько доменов
info@example.com username@gmail.com,username2@gmail.com
```

Сохраним, создадим хэш:
```bash
postmap /etc/postfix/virtual
```

Перезагрузим MTA:
```bash
sudo service postfix reload
```


## Reverse DNS

[Reverse DNS lookup](http://en.wikipedia.org/wiki/Reverse_DNS_lookup), или  reverse DNS resolution (rDNS), нужен для определения доменного имени сервера по его IP. Нужна эта процедура для верификации отправителя: 
- берётся IP сервера, с которого письмо было отправлено
- с помощью rDNS определяется домен
- полученный домен сравнивается с доменом указанным в заголовках письма, в поле «From» 
- если доменные имена совпадают, то считаем что отправитель тот, за кого он себя выдает.

По умолчанию rDNS скорее всего не указывает на ваш сервер. Исправить это просто. Пишем своему хостинг-провайдеру письмо с просьбой настроить Reverse DNS lookup для вашего домена и сервера, IP указываем. 

Как и всё, что связано с DNS, изменения для записей Reverse DNS lookup пройдут не сразу, потому ждём, и через некоторое время проверяем с помощью любого онлайн-сервиса Reverse DNS lookup.

__Настройка rDNS на DigitalOcean:__
- Выбираем пункт «Droplets»
- Выбираем нужный дроплет
- Настройки (Settings)
- Переименовать (Rename)
- Вставляем новый hostname. Hostname равен домену закреплённому за этим дроплетом, типа «example.com».
- Ждём обновления DNS.


## [DomainKeys Identified Mail (DKIM)](http://en.wikipedia.org/wiki/DomainKeys_Identified_Mail)

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install opendkim opendkim-tools
```


```bash
mkdir /etc/postfix/dkim/
opendkim-genkey -D /etc/postfix/dkim/ -d your-site.ru -s mail
```

Только что мы создали секретный (/etc/postfix/dkim/mail.private) и публичный (/etc/postfix/dkim/mail.txt) ключи. Получаем содержимое публичного ключа:

```bash
cat /etc/postfix/dkim/mail.txt

mail._domainkey IN TXT "v=DKIM1;=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnv6Qp34EnmUQMGDFs3tA2f9kRlTQCit3ST3l3xt4Zj3JBeIHnoaMk0Vos/hR/JtNnS16MEMMnX5OgZ3pAJjrk3CCw4hr5THW5zuGfqjSjusEbNckL6+E57Q2DwOjk4d+AjL7cb/fR7MWMMTY6hVVXbRc5VxKUaPp+34mecVyHSQIDAQAB" ; ----- DKIM mail for your-site.ru
```

Содержимое помещаем в DNS запись типа TXT для вашего домена

```txt
Узел: mail._domainkey

Содержимое записи: "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnv6Qp34EnmUQMGDFs3tA2f9kRlTQCit3ST3l3xt4Zj3JBeIHnoaMk0Vos/hR/JtNnS16MEMMnX5OgZ3pAJjrk3CCw4hr5THW5zuGfqjSjusEbNckL6+E57Q2DwOjk4d+AjL7cb/fR7MWMMTY6hVVXbRc5VxKUaPp+34mecVyHSQIDAQAB" 
```

Чиним доступ для OpenDKIM:
```bash
chgrp opendkim /etc/postfix/dkim/*
chmod g+r /etc/postfix/dkim/*
```

В файл конфигурации /etc/opendkim.conf записываем:
```txt
Syslog yes
SyslogSuccess yes
# на время отладки включим расширенное логгирование
LogWhy yes
X-Header yes

Canonicalization relaxed/relaxed
# подпись и проверка подписей
Mode sv
# если только подписываем
#Mode s

# список ключей -
KeyTable file:/etc/postfix/dkim/keytable
# соответствие адресов/доменов и ключей -
SigningTable file:/etc/postfix/dkim/signingtable
# если вы подписываете и на других серверах - 
#ExternalIgnoreList file:/etc/postfix/dkim/trusted
# список внутренних хостов, почта которых требует подписи -
#InternalHosts file:/etc/postfix/dkim/internal
```


Список имеющихся ключей укажем в файле /etc/postfix/dkim/keytable:
```bash
# формат: "название домен:селектор:/путь/до/ключа"
# в качестве названия удобно использовать имя DNS записи с ключем
mail._domainkey.your-site.ru your-site.ru:mail:/etc/postfix/dkim/mail.private
# ключей может быть сколько угодно
mx._domainkey.example.net example.net:mx:/etc/postfix/dkim/mx.private
# (список ключей может быть и в БД - продробней в манах)
```


В файле /etc/postfix/dkim/signingtable указываем соответсвие домен-ключ:
```bash
# формат: "домен-или-адрес название-ключа"
your-site.ru mail._domainkey.your-site.ru

# все остальные адреса тоже подписываем
# в таком случае вся исходящая почта будет подписана 
# этим ключом
* mail._domainkey.your-site.ru
# (подробное описание формат есть в man)
```


В файле /etc/default/opendkim объясним DKIM-демону где ему ждать подключений:
```bash
SOCKET="inet:8891@localhost"
```


Наконец, добавим в конец /etc/postfix/main.cf следующие строки: 
```bash
# Все письма будут отправлены на подпись
milter_default_action = accept
milter_protocol = 2
smtpd_milters = inet:localhost:8891
non_smtpd_milters = inet:localhost:8891
```

Не забываем добавить TXT запись и проверить, что она на месте:
```bash
dig txt mail._domainkey.your-site.ru
```

Или прогнать через валидатор [валидатор](http://dkimcore.org/tools/dkimrecordcheck.html).


Перезапускаем postfix и opendkim
```bash
sudo service postfix reload
sudo service opendkim reload
```

Проверяем работу. Самый простой способ — отправка письма на ящик Яндекс.Почты. Если всё верно настроено, появится зеленый бейджик «Подпись верна». Если неудачно, то в письме (Яндекс) жмём «Подробно -> Свойства письма», ищем слово dkim. Должно быть «dkim=pass». Верху есть ссылки на другие сервисы.

Помним про то, что DNS обновляется не сразу.

Запретим всем серверам принимать письма без подписи с вашего домена, добавим [ADSP запись:](http://habrahabr.ru/post/106589/) 
```txt
_adsp._domainkey IN TXT "dkim=all"
```



## [Sender Policy Framework  (SPF)](http://en.wikipedia.org/wiki/Sender_Policy_Framework)

Требуется для указания IP с которых мы разрешаем отправку. Настройка идёт через DNS-записи. 

Мне обычно хватает простой записи говорящей что почту можно отправлять только с адресов, указанных в записях A и MX:
```txt
your-site.ru. TXT v=spf1 a mx ~all
```
[Почитать про синтаксис SPF](http://www.openspf.org/SPF_Record_Syntax)

Проверить работу можно с помощью [DomainKeys, DKIM, SPF, SpamAssassin Email валидатор](http://www.brandonchecketts.com/emailtest.php). Также можно посмотреть исходники письма в Яндекс.Почте или Gmail.

Проверка на примере Gmail
Отправьте почту через ваш сервис на любой GMail-аккаунт. Откройте полученное письмо и выберите в меню действий пункт Show Original.

Если вы найдете следующие строчки, то всё в порядке:
```txt
Received-SPF: pass
Authentication-Results: ... spf=pass
```


Помним про то, что DNS обновляется не сразу.
