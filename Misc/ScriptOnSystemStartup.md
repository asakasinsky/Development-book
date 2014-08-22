# Load after system startup

Add this string before "exit 0" in /etc/rc.local
```bash
su <username> -c '/path/to/your/script.sh'
# where <username> is a script owner username
```
