# SSH

## Настраиваем SSH сервер

Если каким-то образом пропустили установку openssh, то самое время поставить его сейчас:  
```bash  
sudo apt-get install openssh-server  
You can use the following commands for ssh:  
sudo service ssh start      # Starts SSH Servier  
sudo service ssh restart        # Restarts SSH Server  
sudo service ssh stop           # Stops SSH Server  
sudo service ssh status         # Gives a short description of the status of the SSH server  
```

проверяем:  
```bash  
ssh localhost  
```

Появится приглашение на ввод пароля. Вводим свой пароль. Чтобы завершить ssh-соединение наберем:  
```bash  
logout  
```

или  
```bash  
exit  
```

Вуаля! осталось более тонко настроить ssh и сгенерировать ключи чтоб ходить на сервер без пароля.

Файл настроек  
```bash  
/etc/ssh/sshd_config:  
```

Файл с баннером приветствия:  
```bash  
Banner /etc/ssh/sshd_banner  
```

На хостовой машине генерируем ключ

```bash  
# Генерируем rsa-ключи. Полученные публичный и приватный ключи  
# будут лежать в папке ~/.ssh  
ssh-keygen -t rsa -C "мой-email@mail-bla-bla.com"

# Добавим rsa-ключ агенту аутентификации ssh-agent.  
ssh-add ~/.ssh/id_rsa

# Правим права  
chmod 700 ~/.ssh  
chmod 600 ~/.ssh/id_rsa  
chmod 644 ~/.ssh/id_rsa.pub  
chmod 644 ~/.ssh/authorized_keys  
chmod 644 ~/.ssh/known_hosts

# Теперь можно с легкостью добавлять публичный ключ на сервера (потребуется ввод пароля)  
ssh-copy-id user@server # user - имя пользователя (логин),
                        # и server - либо IP сервера, либо доменное имя

# Входим по SSH (ура, без пароля!!!).  
ssh user@server         # user - имя пользователя (логин),
                        # и server - либо IP сервера, либо доменное имя

```bash

## Алиасы

[ssh_config(5) - Linux man page](http://linux.die.net/man/5/ssh_config)

Файл _~/.ssh/config_  
Если его или папки пока не существует, их надо создать.

Записываем алиас хоста 192.168.56.115

```bash  
Host neon
  HostName 192.168.56.115
  User developer  
```

Используем созданный алиас:  
```bash  
ssh neon  
```




