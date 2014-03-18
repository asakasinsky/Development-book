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

- если установка производится на VM Virtualbox, то нелишним будет это: [VirtualBox.md](/Development%20book/VM/Readme.md)
2. Использование развёрнутого образа на VDS/VPS
    - ввести: <code>lsb_release -a</code>
    - если версия релиза образа меньше требуемой, то [Обновляем версию дистрибутива](/Development%20book/Misc/ReleaseUpgrade.md)
    - если верия устраивает, то ввести: <code>sudo apt-get update && sudo apt-get upgrade</code>

Примечание:
На [Digital Ocean]( https://www.digitalocean.com/?refcode=bbc4266b0488
) (реф. ссылка) можно апгрейдить kernel с помощью [нехитрого способа](/Development%20book/Misc/DOKernelUpgrade.md). 


__Локаль__

[Поддержка кириллицы](/Development%20book/Misc/CyrillicConsole.md)


__Временная зона__

Для проверки выставленной временной зоны введём: 

```bash
# получим текущую дату и время
date
# получим временную зону
more /etc/timezone
```

Если результат не устраивает, то временную зону можно сменить путём:

```bash
sudo dpkg-reconfigure tzdata
```

Затем на всякий случай перезапустим _cron:_

```bash
/etc/init.d/cron stop
/etc/init.d/cron start
```

__Нехорошо всегда ходить на сервер под рутом__, [Исправим это недоразумение](/Development%20book/LEMP/SshDisableRoot.md)

[**Ограничим будущих пользователей домашней папкой**](/Development%20book/Misc/SFTPChrooting.md)

----------------------------------

## Готовим LEMP

Начнем с python-software-properties для удобного добавления репозиториев. Выполним в консоли сервера команды:

[Ставим нужные пакеты](/Development%20book/LEMP/NecessaryPackages.md)

```bash 
mkdir ~/workspace
```

[Nginx](/Development%20book/LEMP/Nginx.md)

[MySQL](/Development%20book/LEMP/Mysql.md)

[PHP](/Development%20book/LEMP/PHP.md)

[Python](/Development%20book/LEMP/Python.md)


## LEMP-helper

LEMP-helper — это небольшой набор инструментов для работы со стеком LEMP. В этот набор входят:

- Заготовки конфигов nginx и php-fpm 
- Создание и удаление проекта по принципу «одно приложение — один пользователь»
    - создаётся пользователь, создаётся окружение в его домашней директории, настраивается резервное копирование, логирование, создаётся база данных, кастомные страницы ошибок и открывается доступ по SFTP
- Удаление проекта

Скачаем хелпер:
```bash
wget https://raw.github.com/asakasinsky/LEMP-helper/master/loader.sh && chmod +x loader.sh && ./loader.sh
```

Теперь нужно убедиться в правильности путей к php.ini и nginx
Нужно учесть, что php для командной строки, скорее всего имеет свою отдельную версию

У меня это пути:
```bash
/etc/php5/fpm/php.ini
/etc/php5/cli/php.ini
```

Настройки nginx лежат обычно тут:
```bash
/etc/nginx/nginx.conf
```

Если у вас всё пути совпадают, можно просто запустить скрипт и он всё сделает сам:
```bash
cd lemp-helper
sudo ./update_lemp_conf.sh
```

Или коректируем команды ниже исходя из своих путей
```bash
cp -R lemp-helper/configs/nginx/nginx-bp /etc/nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
cp -R lemp-helper/configs/nginx/nginx.conf /etc/nginx/nginx.conf

mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.old
cp lemp-helper/configs/php/php.ini /etc/php5/fpm/php.ini

mv /etc/php5/cli/php.ini /etc/php5/cli/php.ini.old
cp lemp-helper/configs/php/php.ini /etc/php5/cli/php.ini
```

## ЛОГИ

Установка Logrotate

```bash
sudo apt-get install logrotate
```

Тестируем:
```bash
logrotate
```

Настраиваем:
```bash
sudo nano /etc/logrotate.d/nginx
```

Первая строка скорее всего выглядит так:
```bash
/var/log/nginx/*.log {
```

Добавим работы logrotate, изменим эту строку:
```bash
/var/log/nginx/*.log /home/*/workspace/*/logs/*.log {
```

Таким нехитрым выражением мы сообщаем logrotate о расположении логов пользователей 
