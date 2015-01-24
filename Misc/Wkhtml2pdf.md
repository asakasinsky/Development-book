Install wkhtml2pdf on ubuntu precise 64bit (12.04 LTS) with patched QT

install-wkhtml2pdf.sh

```bash
# I managed to get the compiled version with patched QT working on ubuntu precise 64bit (12.04 LTS) and thought I'd share my bash history in the hopes it might spare others some trouble shooting.
# Also note that this install process takes rather long, you might want to consider running it in a screen or something
 
# you will be needing git if you haven't got it yet
sudo apt-get install git-core
 
# as per installation instructions, install dependencies for wkhtmltopdf
sudo apt-get install openssl build-essential libssl-dev libxrender-dev
# clone the repo
git clone git://github.com/antialize/wkhtmltopdf.git wkhtmltopdf
 
# install qt dependencies, see http://qt-project.org/doc/qt-4.8/requirements-x11.html
sudo apt-get install libfontconfig1-dev libfreetype6-dev libx11-dev libxcursor-dev libxext-dev libxfixes-dev libxft-dev libxi-dev libxrandr-dev libxrender-dev
 
# get qt
git clone git://gitorious.org/~antialize/qt/antializes-qt.git wkhtmltopdf-qt
cd wkhtmltopdf-qt
git checkout 4.8.4
QTDIR=. ./bin/syncqt
# important here is to note that the -nomake arguments are in quotes as andrei mentioned in the comments before
./configure -nomake "tools examples demos docs translations" -opensource -prefix ../wkqt
# if make fails because you have no Makefile, then something in configure went wrong, check the output for clues
# make -j3 && make install
make -j3
sudo checkinstall --pkgname=wkhtmltopdf-qt --pkgversion="4.8.4" --backup=no --deldoc=yes --fstrans=no --default --addso=yes

# installing wkhtmltopdf
cd ../wkhtmltopdf
# now, run qmake in this directory:
../wkqt/bin/qmake
# finally, make wkhtmltopdf (if you get permission errors, run make and make install as sudo)
# make -j3 && make install
make -j3
sudo checkinstall --pkgname=wkhtmltopdf --pkgversion="0.1" --backup=no --deldoc=yes --fstrans=no --default  --addso=yes
```

INSTALL
sudo dpkg -i DEB_PACKAGE
REMOVE
sudo dpkg -r PACKAGE_NAME

wkhtmltopdf-qt
wkhtmltopdf

/bin/wkhtmltopdf --print-media-type --orientation portrait --page-size A4  http://example.com/pricecatalog.php /PATH-TO-DOCS/price.pdf
