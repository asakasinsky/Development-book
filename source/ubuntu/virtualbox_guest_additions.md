## дополнения гостевой ОС

Обновляем систему.
``` bash
sudo apt-get update && sudo apt-get upgrade
```

Для сборки модуля ядра
``` bash
sudo apt-get install build-essential
```

Технология DKMS позволяет модулям ядра Linux, не включенным в исходный код ядра,  автоматически пересобираться, когда ядро уже собрано. То есть при установке новой версии ядра не придётся драйвер или модуль (в данном случае модуль дополнений гостевой ОС от VirtualBox) собирать заново.
Ставим нужный пакет:
``` bash
sudo apt-get install dkms
```

Заголовочные пакеты для сборки
``` bash
sudo apt-get install linux-headers-`uname -r`
sudo reboot
```

sudo apt-get install virtualbox-guest-additions-iso
sudo mkdir -p /media/cdrom

В меню Virtualbox выбираем Устройства → Установить Дополнения гостевой ОС или нажимаем Host+D. Монтируем cdrom:
``` bash
sudo mount /dev/cdrom /media/cdrom
```

Переходим на смонтированный диск и запускаем установку:
``` bash
cd /media/cdrom && sudo sh ./VBoxLinuxAdditions.run --nox11
```

Дальше доверяемся установщику

groups username
If you don't see vboxsf, join the group by doing this, otherwise skip to step 3:
sudo usermod -a -G vboxsf username
