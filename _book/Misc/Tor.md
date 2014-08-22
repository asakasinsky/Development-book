# Tor

## Installation:

```bash
sudo apt-get install tor
```

## Control via Telnet with Python

You can create a hashed password out of your password using:
```bash
tor --hash-password mypassword
```

nano /etc/tor/torrc

```txt
SocksPort 9150
RunAsDaemon 1
ControlPort 9151
HashedControlPassword 16:56E07731CC59BCB060D5EA71BC528CC1414E0795C2C20B7AC0EB527674
CookieAuthentication 0
```

Restart Tor:
```bash
sudo service tor restart
```


use Torxy (-:
