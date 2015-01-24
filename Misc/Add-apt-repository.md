UBUNTU SERVER 14.4 (TRUSTY TAHR) – ADD-APT-REPOSITORY: COMMAND NOT FOUND

The last time I encountered the add-apt-repository: command not found error I was using Ubuntu Server 12.4 Lucid. The solution then was to install python-software-properties as follows:

sudo apt-get install python-software-properties
 

This did not resolve the issue on my minimal virtual machine installation on Trusty so I installed apt-file – which is an apt package searching utility:

sudo apt-get install apt-file
 

Update apt-file:

apt-file update
 

Finally use apt-file to search for the add-apt-repository package:

apt-file search add-apt-repository
 

As you can see add-apt-repository is in software-properties-common:

software-properties-common: /usr/bin/add-apt-repository
software-properties-common: /usr/share/man/man1/add-apt-repository.1.gz
 

After installing software-properties-common I was able to use add-apt-repository without any further issue:

sudo apt-get install software-properties-common
