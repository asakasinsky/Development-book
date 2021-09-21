## Nginx
    
    Добавим репозиторий NGINX:
    
    ```bash
    # sudo add-apt-repository ppa:nginx/stable
    sudo add-apt-repository ppa:ondrej/nginx
    sudo apt update && sudo apt upgrade
    
    # Устанавливаем nginx
    sudo apt install nginx
    
    # Или, ином случае, сносим установленный, чтобы 
    # затем установить расширенный пакет
    sudo apt remove nginx-common
    sudo apt remove nginx
    sudo apt install nginx-extras
    ```
    
    
    Полезности:
    ```
    nginx -v        # вывод версии
    nginx -V        # подробности о сборке
    nginx -t        # тест конфигурации
    nginx -T        # вывод полной конфигурации
    ```
    
    
    Добавим разрешающее правило для ufw:
    
    ```bash
    sudo ufw app list
    sudo ufw allow "OpenSSH"
    sudo ufw allow "Nginx Full"
    sudo ufw disable
    sudo ufw enable
    ```
    
    Управление nginx'ом
    
    ```bash
    sudo systemctl {start|stop|status} nginx
    nginx -s reload # «мягкая перезагрузка»
    ```
    
    
    ## Выдаём заглушку для дефолтного сервера
    
    ```bash
    sudo -s
    cat /dev/null > /etc/nginx/sites-available/default
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
    ```
    
    ```bash
    nano /etc/nginx/sites-available/default
    server {
        listen       80 default_server;
        server_name  _ ;
        charset utf-8;
        root /var/www/placeholder ;
        index index.html;
    }
    ```
    
    ```bash
    mkdir -p /var/www/placeholder
    ```
    
    Создаём пустой индексный файл в /var/www/placeholder
    
    ```bash
    cat /dev/null > /var/www/placeholder/index.html
    ```
    
    Перезапускаем nginx:
    
    ```bash
    nginx -s reload 
    ```
    
    Выходим из учётки суперпользователя:
    
    ```bash
    exit
    ```
    
    
    ## .htpasswd for Nginx
    
    USER и PASSWORD меняем на свои значения. Имя пользователя может быть любым, не обязательно привязываться к учётным записям, зарегистрированных в системе.
    
    Генерация .htpasswd с помощью apache2-utils:
    ```bash
    sudo apt install apache2-utils
    sudo htpasswd -c /путь-до-htpasswd/.htpasswd USER
>     PASSWORD
    ```
    
    или с помощью openssl, которая, скорее всего уже есть в системе:
    ```bash
    printf "USER:$(openssl passwd -crypt PASSWORD)\n" >> /путь-до-htpasswd/.htpasswd
    ```
    
    В нужный location хоста размещаем что-то типа:
    ```
    location / {
        ...
        auth_basic "Restricted Content";
        auth_basic_user_file /путь-до-htpasswd/.htpasswd;
        ...
    }
    ```
    
