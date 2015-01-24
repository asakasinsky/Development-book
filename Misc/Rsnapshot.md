brew install rsnapshot

0 */4         * * *        /usr/local/bin/rsnapshot hourly
30 3          * * *        /usr/local/bin/rsnapshot daily
0  3          * * 1        /usr/local/bin/rsnapshot weekly
30 2          1 * *        /usr/local/bin/rsnapshot monthly


How to Install Rsnapshot on Ubuntu 12.04 | DigitalOcean
https://www.digitalocean.com/community/tutorials/how-to-install-rsnapshot-on-ubuntu-12-04

Настройка резервного копирования в Ubuntu / Хабрахабр
http://habrahabr.ru/post/45912/
