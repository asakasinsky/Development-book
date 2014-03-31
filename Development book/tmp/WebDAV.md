
Подключаем WebDAV ресурс в Ubuntu

sudo apt-get install davfs2
sudo mkdir /media/yandex.disk

Пробуем подключить диск
sudo mount -t davfs https://webdav.yandex.ru /media/yandex.disk/

Проверяем: 
sudo df -h /media/yandex.disk/

Добавляем строчку
sudo nano /etc/fstab
https://webdav.yandex.ru:443       /media/yandex.disk   davfs         uid=1000,file_mode=640,dir_mode=755,user,noauto    0 0 

Заносим своего пользователя в группу davfs2:
sudo usermod -a -G davfs2 developer
Даём возможность запускать mount.davfs пользователю
sudo chmod 4755 /usr/sbin/mount.davfs

Пробуем монтировать от пользователя:
$ mount /home/пользователь/yandex
И размонтировать:
$ umount /home/пользователь/yandex

