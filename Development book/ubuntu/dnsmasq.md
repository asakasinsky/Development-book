sudo apt-get install dnsmasq  
В конфигурационном файле /etc/dnsmasq.conf раскомментируем  
и отредактируем одну единственую строку:  #address=/double-click.net/127.0.0.1  
редактируем, у меня используется доменная зона dev   ////////////////////////// address=/dev/127.0.0.1,/dep/127.0.0.1  
 address=/dev/127.0.0.1  
перезагружаем  
sudo /etc/init.d/dnsmasq restart  
теперь все URL подобного вида http://site.ru.dev/  
будут направляться на localhost  
