## Изоляция пользователя по SFTP

http://ubuntuforums.org/showthread.php?t=1057657

```bash  
addgroup sftp  
```

Добавляем в конец /etc/ssh/sshd_config  
```bash  
Subsystem sftp internal-sftp  
Match Group sftp
    ChrootDirectory %h
    AllowTCPForwarding no
    ForceCommand internal-sftp  
```

И комментируем там же  
```bash  
#Subsystem sftp /usr/lib/openssh/sftp-server  
```

```bash  
sudo /etc/init.d/ssh restart  
```  
Если поменять владельца у домашней папки, то пользователь по SFTP не сможет выйти из неё. 

```bash  
chown root:root "/home/$USERNAME"  
```
