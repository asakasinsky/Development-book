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

#### Обязательно обновимся
```bash
sudo apt-get update && sudo apt-get upgrade
```

#### Временная зона
```bash
# получим текущую дату и время
date
# получим временную зону
more /etc/timezone
# если временная зона выставлена неправильно, то
sudo dpkg-reconfigure tzdata
```


##### [Поддержка кириллицы в консоли](../Misc/CyrillicConsole.md)

##### [Swap](../Misc/Swap.md)

##### [Ставим нужные пакеты](./NecessaryPackages.md)

##### [Отключим вход по ssh пользователю root](../Misc/SshDisableRoot.md)


## LEMP

##### [Nginx](./Nginx.md)
##### [MySQL](./MySQL.md)
##### [PHP](./PHP.md)
##### [Python](./Python.md)

## ЛОГИ

Установка Logrotate
```bash
sudo apt-get install logrotate
```

Тестируем:
```bash
logrotate
```

Я сторонник того чтобы логи, относящиеся к пользовательскому приложению, находились в директории пользователя. Вот так:
```bash
/home/<USERNAME>/logs
```

Сделаем так, чтобы logrotate начал обслуживать эту директорию с логами.
```bash
nano /etc/logrotate.d/<USERNAME>.logrotate

/home/<USERNAME>/logs/*.log {
    daily
    rotate 7
    compress
    delaycompress
    notifempty
    missingok
    copytruncate
    su root <USERNAME>
}
```

Поправим права
```bash
ls -la /etc/logrotate.d
chmod 644 /etc/logrotate.d/*
```

Протестируем созданный конфиг:
```bash
sudo logrotate -d /etc/logrotate.d/<USERNAME>.logrotate
```


## Мониторинг 

##### [Logwatch](./Logwatch.md)

## Безопасность

##### [UFW — сетевой экран](./UFW.md)
##### [Tripwire — контроль целостности системы](./Tripwire.md)

## Тюнинг

##### [Sysctl](./Sysctl.md)
