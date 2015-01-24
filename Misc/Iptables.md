

microHOWTO: Make the configuration of iptables persistent (Debian)
http://www.microhowto.info/howto/make_the_configuration_of_iptables_persistent_on_debian.html

If I reboot my VPS, will the rules still be in place?
 x109justice
x109justice September 4, 2014
you have to save the rules

sudo apt-get install iptables-persistent
sudo service iptables-persistent start

iptables -L


=============
в debian и ubuntu добавили пакет iptables-persistent
который использует iptables-save/iptables-restore

#service iptables-persistent 
Usage: /etc/init.d/iptables-persistent {start|restart|reload|force-reload|save|flush}

после настройки правил как нужно, сделать service iptables-persistent save и при следующей загрузке они будут применены
==============

/etc/init.d/iptables-persistent
Добавит туда ipset save / ipset restore
-------
Вот что имелось ввиду в совете и то, что мне помогло:

Для начала должен быть установлен пакет iptables-persistent. На Debian устанавливаем так
apt-get install iptables-persistent

Этот пакет нам позволит сохранять командой из консоли правила IPTABLES. После перезагрузки правила iptables сбрасываться перестанут.

Далее редактируем скрипт запуска /etc/init.d/iptables-persistent
Находим секуцию save_rules() и дописываем в нее вначале строку
ipset save > /etc/ipset.rules
Это будет сохранять сеты IPSET при каждом сохранении правил iptables с помощью iptables-persistent.

После этого находим секцию load_rules() и добавляем вначале строку
ipset restore < /etc/ipset.rules
Это будет загружать сеты IPSET при каждой загрузке правил iptables с помощью iptables-persistent.

Этот вариант на мой взгляд самый удобный. Одной командой из консоли cохраняются и правила iptables и сеты Ipset. После перезагрузки правила сохранятся.
service iptables-persistent save
