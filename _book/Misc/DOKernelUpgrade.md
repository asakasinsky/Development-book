# Апгрейд ядра на DigitalOcean

Данный способ позволяет поставить произвольную версию ядра. Дело в том, что на этом хостинге обычным способом получится проапгрейдится получится только до той версии ядра, которая указана в панели управления дроплетом.

> Зачем апгрейдить kernel? Например, без этого у меня не получалось установить lxml в virtualenv, установка вылетала с жалобой на gcc  

Откроем файл:  
```bash  
sudo nano /etc/init.d/rcS  
```

Поместим туда следующее содержимое:  
```bash  
if grep -qv ' kexeced$' /proc/cmdline ;then
        kexec --load /vmlinuz --initrd=/initrd.img --append='root=LABEL=DOROOT kexeced' &&
        kexec -e  
fi

exec /etc/init.d/rc S  
```

Далее:  
```bash  
sudo apt-get install linux-image-generic-lts-raring  
sudo apt-get install linux-headers-generic-lts-raring

sudo apt-get install -y kexec-tools  
sudo poweroff  
```

Затем загружаем дроплет из панели управления

<code>uname -r</code>code> должен показать «правильное» ядро,  
а <code>cat /proc/cmdline</code> должен сказать:  
<code>root=LABEL=DOROOT kexeced</code>
