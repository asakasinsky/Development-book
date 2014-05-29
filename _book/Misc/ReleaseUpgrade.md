# Realease Upgrade

Check version  
```bash  
lsb_release -a  
```

Check free disk space  
```bash  
df -h /  
```

Check free memory  
```bash  
grep MemTotal /proc/meminfo  
```

or  
```bash  
free -m  
```

```bash  
sudo apt-get update  
sudo apt-get upgrade

sudo apt-get install update-manager-core  
sudo apt-get install nano mc  
```

Edit _/etc/update-manager/release-upgrades_ and set:  
```bash  
[DEFAULT]  
Prompt=lts  
```

To upgrade to a newer release, from a terminal prompt enter:  
```bash  
do-release-upgrade  
```

It is also possible to use do-release-upgrade to upgrade to a development version of Ubuntu. To accomplish this use the _-d_ switch:  
```bash  
do-release-upgrade -d  
```

At the end of the upgrade process you will be required to restart the server in order to boot into the new kernel. If you do not have access to the console of the system you are upgrading, you may need to edit /boot/grub/menu.lst and change the default boot kernel to the newly installed 12.04 kernel. If this step is not performed your server may attempt to boot into the 10.04 LTS kernel and will hang.

Cleaning:  
```bash  
sudo apt-get clean  
sudo apt-get autoremove  
```

Updating:  
```bash  
sudo apt-get update  
```  
```bash  
sudo apt-get -f install  
```

This is usually enough.  
If you mess with dependencies, intelligent update system help you:  
```bash  
sudo apt-get dist-upgrade  
```

If installation was interrupted:  
```bash  
sudo apt-get install --reinstall package-name  
```

If any repo not accessible, fix it:  
```bash  
/etc/apt/sources.list    # Main repo's list  
/etc/apt/sources.list.d  # third-parties repo's directory  
```bash

If you can not remove/reinstall any package, fix it:  
```bash  
/var/lib/dpkg/status      # list of installed packages  
/var/lib/dpkg/available   # list of available packages  
```

