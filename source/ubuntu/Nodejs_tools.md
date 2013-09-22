Несмотря на то, что есть возможность поставить node из репозитория, 
sudo apt-get update
sudo apt-get install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
будем ставить пакет, собранный из исходников, так как нужна более свежая версия, чем показывает `apt-cache policy nodejs` (репозиторий был подключен)

Утилита для сборки пакета, делающая в принципе то же самое, что делает `make install`, но при этом регистрируя устанавливаемую программу в пакетной базе дистрибутива.
sudo apt-get install checkinstall

echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
. ~/.bashrc
mkdir ~/local
mkdir ~/node-latest-install
cd ~/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=~/local
make
sudo checkinstall -D

Появится диалог смены опций. Нужно поменять версию, иначе в дальнейшем появится ошибка из-за того что номер версии должен начинатся с цифры. На данный момент версия - 0.10.15

В принципе всё должно пройти нормально. Пакет всегда можно удалить с помощью `dpkg -r имя пакета(в нашем случае node-latest)`
Проверяем версию: `node -v`.

----------

Ставим NPM - пакетный менеджер
curl https://npmjs.org/install.sh | sh

----------

Ставим grunt
npm install grunt-cli -g
_Обычно запуск npm приходится делать под учётной записью администратора или через sudo, но мы изначально поставили node в ~/local, домашней директории_

[Шаблон проекта](http://nano.sapegin.ru/all/grunt-0-4)

----------

Ставим imgo по инструкции
Внимание, в Linux Debian пакет imgo получиться поставить полностью только на платформах i686 и x86_64 в связи с отсутствием пакета defluff для платформы x86
https://github.com/imgo/imgo
sudo npm install -g grunt-recess

----------

## JSBIN

npm install -g jsbin
npm install -g forever

cd /local/lib/node_modules/jsbin
[run.js](https://gist.github.com/asakasinsky/6146565)

[config.local.json](https://gist.github.com/asakasinsky/6146569)

cd
nano jsbin_stop.sh
```
cd /usr/lib/node_modules/jsbin
mysql -uroot -ppassword jsbin < build/full-db-v3.mysql.sql

PORT=8000 forever stop --append -l forever.log run.js
```

nano jsbin_start.sh
```
cd /usr/lib/node_modules/jsbin
PORT=8000 forever start --append -l forever.log run.js
```



https://gist.github.com/4439325

поправки:

