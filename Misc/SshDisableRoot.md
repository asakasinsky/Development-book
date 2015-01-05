# Отключаем вход рутом по SSH

Если установка происходит в условиях VPS/VDS, то скорее всего пользователь под которым вы находитесь — root и он скорее всего единственный пользователь. Если это так, то заведём себе пользователя для администрирования, ибо под рутом сидеть нельзя

```bash  
useradd zeus -m -G sudo -s "/bin/bash" -d "/home/zeus"  
```

Зададим ему пароль  
```bash  
passwd zeus  
```

Отключим вход по SSH под рутом  
```bash  
nano /etc/ssh/sshd_config  
```

Меняем значение **PermitRootLogin** на **no**

**Перед этим убедись**, создал ли ты пользователя для администрирования иначе больше на сервер не зайдёшь  
```bash  
service ssh restart  
```

Выйдем  
```bash  
logout  
```

Добавим ssh публичный ключ  
```bash  
ssh-add ~/.ssh/id_rsa  
ssh-copy-id zeus@188.226.129.213  
```

для полного счастья можно добавить алиас в ~/.ssh/config  
придумайте название алиаса, например saturn

```bash  
Host saturn
    Hostname 188.226.129.213
    User zeus  
```

теперь можно соединится  
```bash  
ssh saturn  
```

Это лучше чем постоянно вспоминать IP серверов

Bashrc at ssh login

.bashrc is not sourced when you log in using SSH. You need to source it in your .bash_profile like this:

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
