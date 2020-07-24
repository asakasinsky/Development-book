## SSH

Generate rsa-keys. Generated public and private keys will be put in the .ssh folder
```zsh
ssh-keygen -t rsa -C "my-email@mail-bla-bla.com"
```

Add the rsa-key to ssh-agent.
```zsh
ssh-add ~/.ssh/id_rsa
```

Set permissions:
```zsh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
```

Now you can easily add the public key to the server (you'll need a password)
```zsh
ssh-copy-id user@server # user - username (login),
                        # server - server IP or domain
```

Enter by SSH (no password, hooray!).
```zsh
ssh user@server         # user - username (login),
                        # server - server IP or domain
```