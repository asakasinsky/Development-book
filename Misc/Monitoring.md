# vnStat
установка
sudo apt-get install vnstat
смотрим интерфейсы
ifconfig
Обновляем данные по нужному интерфейсу. Первый запуск инициализирует БД по этому интерфейсу. 
sudo vnstat -i eth0 -u
По умолчанию демон vnStat обновляет базу данных каждые 5 минут, а «снимает» информацию с интерфейсов каждые 30 секунд.

Принудительно обновить БД
sudo vnstat -u
Запускаем службу
sudo service vnstat start

Просмотр статистики

общая
vnstat
по конкретному интерфейсу
vnstat -i eth0
По часам
vnstat -i eth0 -h
По дням 
vnstat -i eth0 -d
По неделям
vnstat -i eth0 -w
По месяцам
vnstat -i eth0 -m
В реальном времени
vnstat -i eth0 -l

# Nagios

Based from:
http://www.rittmanmead.com/2012/09/an-introduction-to-monitoring-obiee-with-nagios/

Разобрать примеры
https://github.com/C4Tech/nagios-scripts/blob/master/check_rsnapshot
http://marcelo-olivas.blogspot.ru/2012/02/using-logwarn-to-manage-logs-along-with.html


### Client Server Setup

```bash
sudo apt-get install nagios-plugins nagios-nrpe-server
```


/usr/lib/nagios/plugins/ content:
```bash
check_apt       check_icmp          check_nagios     check_sensors        
check_bgpstate  check_ide_smart     check_nntp       check_simap           
check_breeze    check_ifoperstatus  check_nntps      check_smtp               
check_by_ssh    check_ifstatus      check_nt         check_snmp        
check_clamd     check_imap          check_ntp        check_spop     
check_cluster   check_ircd          check_ntp_peer   check_ssh          
check_dhcp      check_jabber        check_ntp_time   check_ssmtp            
check_dig       check_ldap          check_nwstat     check_swap        
check_disk      check_ldaps         check_oracle     check_tcp       
check_disk_smb  check_linux_raid    check_overcr     check_time            
check_dns       check_load          check_pgsql      check_udp     
check_dummy     check_log           check_ping       check_ups   
check_file_age  check_logwarn       check_pop        check_users      
check_flexlm    check_mailq         check_procs      check_wave      
check_ftp       check_mrtg          check_radius     negate      
check_host      check_mrtgtraf      check_real       urlize        
check_hpjd      check_mysql         check_rpc        utils.pm          
check_http      check_mysql_query   check_rta_multi  utils.sh 
```


```bash
mkdir -p /tmp/logwarn
# add this string before "exit 0" in /etc/rc.local
mkdir -p /tmp/logwarn
```

Open the sudoers file (/etc/sudoers) in an «visudo» editor

_Note: Never edit this file with a normal text editor! Always use the visudo command instead!_

```bash
nagios ALL=(ALL) NOPASSWD:/usr/lib/nagios/plugins/check_logwarn
```

Add Nagios user to MySQL:
```bash
mysql -u root -p
> CREATE USER 'nagios'@'localhost' IDENTIFIED BY 'NAGIOS_PASSWORD';
> GRANT ALL PRIVILEGES ON * . * TO 'nagios'@'localhost';
```

Add nginx/php-fpm error log parser plugin^
```bash
sudo nano /usr/lib/nagios/plugins/check_nginx_log
# add content from https://gist.github.com/asakasinsky/ff85e88b9c641c83217c
```

### Client config
```bash
sudo nano /etc/nagios/nrpe.cfg

log_facility=daemon
pid_file=/var/run/nagios/nrpe.pid
server_port=5666
nrpe_user=nagios
nrpe_group=nagios
allowed_hosts=YOUR_MONITORING_SERVER_IP
dont_blame_nrpe=1
debug=0
command_timeout=60
connection_timeout=300
include=/etc/nagios/nrpe_local.cfg
include_dir=/etc/nagios/nrpe.d/
command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_hda1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/xvda2
command[check_zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200    

command[check_mysql]=/usr/lib/nagios/plugins/check_mysql -d DATABASE_NAME -H 127.0.0.1 -u nagios -p NAGIOS_PASSWORD

# check ^.*error
# command[check_error_log]=/usr/bin/sudo /usr/lib/nagios/plugins/check_logwarn -d /tmp/logwarn -p /home/<username>/workspace/logs/error.log ^.*error

command[check_nginx_log]=/usr/bin/sudo /usr/lib/nagios/plugins/check_nginx_log /home/<username>/workspace/logs/error.log

```



### Firewall config
```bash
iptables -N NRPE
iptables -I INPUT -s 0/0 -p tcp --dport 5666 -j NRPE
iptables -I NRPE -s YOUR_MONITORING_SERVER_IP -j ACCEPT
iptables -A NRPE -s 0/0 -j DROP
/sbin/iptables-save

service nagios-nrpe-server restart
```



### Monitoring Server Setup
```bash
sudo apt-get install nagios3 nagios-nrpe-plugin 

sudo usermod -a -G nagios www-data
sudo chmod -R g+x /var/lib/nagios3/
sudo sed -i 's/check_external_commands=0/check_external_commands=1/g' /etc/nagios3/nagios.cfg

sudo htpasswd -c /etc/nagios3/htpasswd.users nagiosadmin
sudo service nagios3 restart && sudo service apache2 restart
```



### Add Client To Monitoring
```bash
sudo nano /etc/nagios3/conf.d/example.com.cfg



define host {
    use                     generic-host
    host_name               my-server
    hostgroups              http-servers
    alias                   example.com
    address                 88.198.200.80
    check_period 24x7
    notification_interval 60
    }





sudo service nagios3 restart
```


## Смотри настройки 
/etc/nagios3/conf.d


## Email Alerts

Test mailx work:
```bash
echo 'Email works from the Nagios server' | mailx -s 'Test message from Nagios' asakasinsky@gmail.com
```


