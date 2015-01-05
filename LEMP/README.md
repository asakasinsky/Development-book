Установка стека решений LEMP
---------------------------

_LEMP — это акроним, состоящий из начальных букв четырёх программных компонентов стека web-приложений полностью состоящего из свободного программного обеспечения с открытыми исходными кодами._

## Программные компоненты

__Linux:__ дистрибутив Unix-подобной и POSIX-совместимой операционной системы.  Как правило, это Ubuntu или Debian.

__EngineX (Nginx):__ HTTP-сервер, отличная альтернатива Apache, входящего в более традиционный стек LAMP. Nginx отличается низким потреблением памяти и высокой стабильностью.

__MySQL, MariaDB, MongoDB:__ 
- MySQL — реляционная система управления базами данных. 
- MariaDB — это форк MySQL, появившийся из-за неопределённой политики лицензирования MySQL. 
- MongoDB — это NoSQL система управления базами данных.

__PHP, Perl, Python:__ 
- PHP — это широко распространённый скриптовый язык программирования в Web-окружении
- Perl — это скриптовый язык программирования изнначально предназначенный для работы с текстовой документацией.
- Python — это скриптовый язык программирования широкого назначения

----------------------------------

## Подготовка

- если установка производится на VM Virtualbox, то нелишним будет это: [VirtualBox.md](../VirtualBox/README.md)
2. Использование развёрнутого образа на VDS/VPS
    - ввести: <code>lsb_release -a</code>
    - если версия релиза образа меньше требуемой, то [Обновляем версию дистрибутива](../Misc/ReleaseUpgrade.md)
    - если верия устраивает, то ввести: <code>sudo apt-get update && sudo apt-get upgrade</code>

Примечание:
На [Digital Ocean]( https://www.digitalocean.com/?refcode=bbc4266b0488
) (реф. ссылка) можно апгрейдить kernel с помощью [нехитрого способа](../Misc/DOKernelUpgrade.md). 
>> Подготовка

<<<<<<< HEAD


__Локаль__

[Поддержка кириллицы](../Misc/CyrillicConsole.md)


__Временная зона__

Для проверки выставленной временной зоны введём: 

```bash
=======
sudo apt-get update && sudo apt-get upgrade
==========
Временная зона
>>>>>>> draft
# получим текущую дату и время
date
# получим временную зону
more /etc/timezone
==========

https://github.com/asakasinsky/Development-book/blob/master/Misc/CyrillicConsole.md
==========

Ставим нужные пакеты
https://github.com/asakasinsky/Development-book/blob/master/LEMP/NecessaryPackages.md
==========

Swap
https://github.com/asakasinsky/Development-book/blob/master/Misc/Swap.md

Нехорошо всегда ходить на сервер под рутом, Исправим это недоразумение
Development-book/SshDisableRoot.md at master · asakasinsky/Development-book · GitHub
https://github.com/asakasinsky/Development-book/blob/master/Misc/SshDisableRoot.md



<<<<<<< HEAD


__Swap__

[Swap файл](../Misc/Swap.md)


----------------------------------
=======
>>>>>>> draft

>> LEMP

Nginx
https://github.com/asakasinsky/Development-book/blob/master/LEMP/Nginx.md
==========

MySQL
https://github.com/asakasinsky/Development-book/blob/master/LEMP/MySQL.md
==========

PHP
https://github.com/asakasinsky/Development-book/blob/master/LEMP/PHP.md
==========

Python
https://github.com/asakasinsky/Development-book/blob/master/LEMP/Python.md
==========


>> ЛОГИ

Установка Logrotate

sudo apt-get install logrotate
Тестируем:

logrotate
Настраиваем:

sudo nano /etc/logrotate.d/nginx
Первая строка скорее всего выглядит так:

/var/log/nginx/*.log {
Добавим работы logrotate, изменим эту строку:

/var/log/nginx/*.log /home/*/workspace/*/logs/*.log {
Таким нехитрым выражением мы сообщаем logrotate о расположении логов пользователей

ls -la /etc/logrotate.d
chmod 644 /etc/logrotate.d/*

sudo logrotate -d /etc/logrotasudo logrotate -d /etc/logrotate.d/likadress.logrotate

```bash
/home/likadress/logs/*.log {
    daily
    rotate 52
    compress
    delaycompress
    notifempty
    missingok
    copytruncate
    su root likadress
}
```


>> Сервер почтовых рассылок

https://github.com/asakasinsky/Development-book/blob/master/UsefulThings/MailServerSettings.md




>> Мониторинг

Logwatch
https://github.com/asakasinsky/Development-book/blob/master/LEMP/Logwatch.md
==========




>> Безопасность

==========
Сетевой экран
https://github.com/asakasinsky/Development-book/blob/master/LEMP/UFW.md

Обнаружение вторжений 
Tripwire
https://github.com/asakasinsky/Development-book/blob/master/LEMP/Tripwire.md
==========



Тюнинг
sysctl net.core.somaxconn
поставим равным количеству worker connection
# Теперь значение сохранится при перезагрузке системы
echo net.core.somaxconn = 4000 >> /etc/sysctl.conf && sysctl -p


