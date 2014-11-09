# Web2Pdf

## Dependencies 

```bash
sudo apt-get install openssl build-essential libssl-dev libxrender-dev git-core libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig libicu48 checkinstall
sudo apt-get install ttf-mscorefonts-installer
```

_Note: We will use patched QT, we are no need X11_

Clone the current wkhtmltopdf repository from GitHub.
```bash
git clone git://github.com/wkhtmltopdf/wkhtmltopdf.git wkhtmltopdf
```

Clone the current patched QT from Gitorius.
```bash
git clone -b wk_4.8.5 git://github.com/wkhtmltopdf/qt.git qt-wkhtmltopdf
cd qt-wkhtmltopdf
```

At the time of writing, the latest stable patched QT branch was wk_4.8.5, please check out the wkhtmltopdf GitHub page for up to date info.

Configure and build QT. Unless you've got a newer machine, this will take a long time (on an EC2 m1.large, it took about 4 hours).
```bash
./configure -nomake tools,examples,demos,docs,translations -opensource -prefix "`pwd`" `cat ../wkhtmltopdf/static_qt_conf_base ../wkhtmltopdf/static_qt_conf_linux | sed -re '/^#/ d' | tr '\n' ' '`

make -j2
```
You should increase/lower the build jobs (-j#) depending on your system. On an EC2 m1.large, I used -j2 (one for each CPU core).


Compile wkhtmltopdf.
```bash
cd ../wkhtmltopdf
../qt-wkhtmltopdf/bin/qmake
make -j2
```

Make .deb package^
```bash
checkinstall -D
source ~/.bashrc
```

Package was installed, and you can remove it from your system anytime using:
```bash
dpkg -r wkhtmltopdf
```

## Scheduler

```bash
mkdir -p /home/likadress/workspace/likadress.ru/htdocs/docs
chmod 777 /home/likadress/workspace/likadress.ru/htdocs/docs
```

```bash
crontab -u likadress -e

00 * * * *  wkhtmltopdf --print-media-type --orientation portrait --page-size A4  http://likadress.ru/pricecatalog.php /home/likadress/workspace/likadress.ru/htdocs/docs/price.pdf
```
