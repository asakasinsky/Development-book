Webmin — известный веб-интерфейс для системного администрирования Unix систем. Т.е. используя любой браузер, можно получить быстрый доступ к функциям вашего сервера (включая удобную правку конфигурационных файлов). Сам пакет представляет собой простой веб-сервер и кучу скриптов. Вот один из наиболее удобных способов его установки:


1. Редактируем файл /etc/apt/sources.list:

sudo nano /etc/apt/sources.list
И добавляем в него:

deb http://download.webmin.com/download/repository sarge contrib
deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib
Сохраняем и выходим.

 

2. Импортируем GPG ключ:

wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
 

3. Обновляем список источников:

sudo apt-get update
 

4. Устанавливаем Webmin:

sudo apt-get install webmin
Готово! Все необходимые для его работы пакеты, будут установлены автоматически.

 

5. Теперь заходим в Webmin: https://ваш-сервер:10000/

------------------------------

## Как установить модуль Webmin?

logon to webmin then, Webmin > Webmin configuration > Webmin Modules > (check) Third party module from ... then click buton labeled "..." find VSFTPD module on the list. click the module name. it will give you the module installation link in main window. then install...

------------------------------

http://www.curvve.com/blog/guides/2013/guide-to-setup-virtualmin-with-nginx-and-php-fpm/
Панель управления хостингом

------------------------------

OK, I had to go to the customer premises and found a solution. I:

Exported the keystore that holds the signing keys in PKCS #12 format
Opened control panel Java -> Security tab
Clicked Manage certificates
Imported this new keystore as a secure site CA
Then I opened the JAWS application without any warning. This is a little bit cumbersome, but much cheaper than buying a signed certificate!



