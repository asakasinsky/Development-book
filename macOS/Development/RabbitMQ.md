## RabbitMQ

```zsh
brew install rabbitmq
```
To have launchd start rabbitmq now and restart at login:
```
brew services start rabbitmq
```

Or, if you don't want/need a background service you can just run:
```
rabbitmq-server
```


```zsh
lsof -Pni4 | grep LISTEN | grep 15672

rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_vhost <VHOST>
rabbitmqctl add_user <USER> <PASSWORD>
rabbitmqctl set_permissions -p <VHOST> <USER> ".*" ".*" ".*"
rabbitmqctl set_user_tags <USER> administrator management

# RabbitMQ management UI
http://127.0.0.1:15672/#/queues
```


__php extension__
```zsh
brew install rabbitmq-c

# copy the path to rabbitmq-c
brew info rabbitmq-c
> ...
> /usr/local/Cellar/rabbitmq-c/0.10.0

pecl install amqp
# set the path to rabbitmq-c

php -i|grep amqp
```