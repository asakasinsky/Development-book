## Log Rotating

Requirements:  
- every day log rotation by default
- log size also will trigger log rotation 
- keep last seven «old» log files
- compressing 


__[newsyslog](https://www.freebsd.org/cgi/man.cgi?newsyslog.conf\(5\))__ — default log management service.

Here is an example for MySQL service. The configuration file named _mysql.error.conf_ and placed in the directory <code>/etc/newsyslog.d/</code>.

_/etc/newsyslog.d/mysql.conf_
```
# logfilename                   [owner:group]   mode count size(KB)  when  flags [/pid_file]                            [sig_num]
/usr/local/var/mysql/*.log  :                   644  7     2048      *     JG    /usr/local/var/mysql/mysql.pid 
```

Test it:
```
sudo newsyslog -nvv
```

__logrotate__
```zsh
brew install logrotate
brew services start|restart|stop logrotate
```

Configuring:
```
/usr/local/etc/logrotate.d/*
```


Here is an yet example for MySQL service. The configuration file named _mysql.conf_ and placed in the directory <code>/usr/local/etc/logrotate.d/</code>.

_/usr/local/etc/logrotate.d/mysql.conf_
```
/usr/local/var/mysql/*.log {
  daily
  copytruncate
  rotate 7
  size 2M
  compress
}
```

Test it:
```
sudo  logrotate -v -f /usr/local/etc/logrotate.d
```

