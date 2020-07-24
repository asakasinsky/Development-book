## MySQL ver 8


__Installation__
```zsh
brew info mysql
brew install mysql

# brew services start|restart|stop mysql
brew services start mysql

mysql_secure_installation
# Validate pass - N
# Change pass for root - n
# Anonym users - y
# Remote root access - y
# Test tables - y
# Reload privilige - y

# Where is a configuration file?
mysql --help | grep "Default options" -A 1
> Default options are read from the following files in the given order:
> /etc/my.cnf /etc/mysql/my.cnf /usr/local/etc/my.cnf ~/.my.cnf

# Log and PID file location
mysql -uroot -p -se "SHOW VARIABLES" | grep -e log_error -e general_log -e slow_query_log -e pid_file
```


__MySQL Shell Usage Example__
```zsh
# MySQL Command Console
mysql -u user -p 

# Pass query
mysql -u user -p -e 'Your SQL Query Here' database-name
# -u : Specify mysql database user name
# -p : Prompt for password
# -e : Execute sql query
# database : Specify database name
```


__Error: «Authentication plugin 'caching_sha2_password' cannot be loaded»__
```zsh 
# 1. Change the authentication plugin:
echo 'default_authentication_plugin=mysql_native_password' >> /usr/local/etc/my.cnf
brew services restart mysql

# 2. Change the encryption of the user's password:
mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '<PASSWORD>';"
```


__Allow Wildcard (%) Access if You Need:__
```mysql
UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';
FLUSH PRIVILEGES;
```

