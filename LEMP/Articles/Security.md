## Разные записи


rkhunter и в дополнение бегает chkrootkit
ssh только по сертификатам, хотя за root'а вход почти всегда оставляю. Однако ssh ныкаю от внешнего мира через iptables knock.
Кое-где использую tripwire для контроля целостности.
fail2ban бегает. Постоянно стопит bruteforce Asterisk'а)
logwatch

установка сервера с ноля
либо снапшот либо контроль целостности
tripware



Диагностика

Чаще все приходится сталкиваться с проблемами обновления или установки. Тут, конечно, детализировать что-то сложно — можно только посоветовать, если обновляется дистрибутив, делать это через screen
Например:
screen -S upgrade
apt-get update
apt-get dist-upgrade
do-release-upgrade

Причина одной из самых распространенных проблем — банальная нехватка места на диске
df -h

Иногда бывает, что место есть а нодов свободных нет. Тогда это тоже приведет к сбою обновления и дальнейшим проблемам.
df -i



Безопасность




# Воспользуйтесь last и посмотрите кто заходил в систему, с каких адресов.
last
Если есть подозрение, что нас взломали или ломают, то первым делом нужно глянуть кто сейчас на сервере:
who
Глянуть на историю
history



 Отловить lsof'ом какой процесс изменяет файлы не получается. Вывожу ps auxww и вижу, что висит некий процесс cat /sys/class/net/lo/operstate

 убеждаемся, что никто подозрительный их не слушает открытых портов
netstat -tunap | grep LISTEN
или так 
nmap -P0 78.47.135.73


# do an ls -l /etc/passwd and see when the last time the file was changed.
ls -l /etc/passwd

# Проверьте планировщик на предмет запускаемых сервисов / скриптов:
crontab -u root -l
# Проверьте системный /etc/crontab
cat /etc/crontab

## Ищем руткиты

wget http://sourceforge.net/settings/mirror_choices?projectname=rkhunter&filename=rkhunter/1.4.2/rkhunter-1.4.2.tar.gz
tar xzvf rkhunter*
cd rkhunter*
sudo ./installer.sh --layout /usr --install

sudo apt-get update
sudo apt-get install binutils libreadline5 libruby1.8 ruby ruby1.8 ssl-cert unhide.rb mailutils

sudo rkhunter --versioncheck
sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter -c --enable all --disable none
https://www.digitalocean.com/community/tutorials/how-to-use-rkhunter-to-guard-against-rootkits-on-an-ubuntu-vps


sudo apt-get install chkrootkit
chkrootkit
Searching for Suckit rootkit... Warning: /sbin/init INFECTED
[Не паникуйте, разработчики из RedHat считают это багом: Ложное срабатывание сhkrootkit связанное со спецификой systemd](https://bugzilla.redhat.com/show_bug.cgi?id=636231)


## Проверяем контрольные суммы
# сейчас, если предположить что вам изменили уже установленные файлы, найти расхождения поможет утилита debsums.
debsums > report.txt


