[Четыре шага в защите SSH](http://www.xakep.ru/post/35288/)  
[Port knocking или как обезопасить себя от брута по ssh](http://habrahabr.ru/post/179219/)  
[Пять простых шагов для защиты ssh в Ubuntu. Часть I](http://anosov.org.ru/2011/07/five-simple-steps-for-ssh-protect-in-ubuntu/)  
[Пять простых шагов для защиты ssh в Ubuntu. Часть II — Port knocking](http://anosov.org.ru/2011/08/port-knocking/)  

--------------------------

Настраиваем SSH сервер
Если каким-то образом пропустили установку openssh, то самое время поставить его сейчас:
sudo apt-get install openssh-server

проверяем: 
ssh localhost
Появится приглашение на ввод пароля. Вводим свой пароль. Чтобы завершить ssh-соединение наберем: 
logout
или 
exit

[Настройка сетевых интерфейсов](Network_Interfaces.md)

Вуаля! осталось более тонко настроить ssh и сгенерировать ключи чтоб ходить на сервер без пароля.


файл настроек 
sudo nano /etc/ssh/sshd_config



приветствие
Banner /etc/ssh/sshd_banner



и разрешил вход пользователю developer с любых адресов
UsePAM yes

AllowUsers developer@*

(
варианты:
AllowUsers user1@* user2@192.168.1.10 *@192.168.1.*
DenyUsers user4
)
На просторах сети была найдена пара хаков для ускорения подключения. 

В файле /etc/pam.d/sshd /etc/pam.d/login закомментируем строки

session optional pam_motd.so


и удалим landscape-клиент:
sudo apt-get remove landscape-client landscape-common

На хостовой машине генерируем ключ


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

# Выводим на консоль публичный ключ
# В настройках GitHub добавляем его содержимое
cat ~/.ssh/id_rsa.pub

# Тестируем соединение
# GitHub должен поприветствовать нас, если все получилось
ssh -T git@github.com

# Для удобства добавления ключей на сервера 
# существует утилита ssh-copy-id, но в OSX она 
# отсутствует, ставим ее
curl https://raw.github.com/beautifulcode/ssh-copy-id-for-OSX/master/ssh-copy-id.sh -o /usr/local/bin/ssh-copy-id
chmod +x /usr/local/bin/ssh-copy-id

# Теперь можно с легкостью добавлять публичный ключ на сервера (потребуется ввод пароля)
ssh-copy-id user@server # user - имя пользователя (логин),
                        # и server - либо IP сервера, либо доменное имя

# Входим по SSH (ура, без пароля!!!).
ssh user@server         # user - имя пользователя (логин),
                        # и server - либо IP сервера, либо доменное имя
