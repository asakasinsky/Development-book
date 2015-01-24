# Installing RabbitMQ Ubuntu 14.04 with PHP extension

apt-get update
apt-get install rabbitmq-server
sudo pecl install amqp



if error

```bash
make: *** [amqp_queue.lo] Error 1
ERROR: `make' failed
```
Then
```bash
# Download the rabbitmq-c library
 git clone git://github.com/alanxz/rabbitmq-c.git
 cd rabbitmq-c
 # Enable and update the codegen git submodule
 git submodule init
 git submodule update
 # Configure, compile and install
 autoreconf -i && ./configure && make && sudo make install
```

After that, 
```bash
sudo pecl install amqp 
```
did the work.

echo "extension=amqp.so" > /etc/php5/cli/conf.d/amqp.ini
echo "extension=amqp.so" > /etc/php5/fpm/conf.d/amqp.ini
sudo service php5-fpm reload

