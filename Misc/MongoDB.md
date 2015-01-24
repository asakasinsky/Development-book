sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org
mongod --version

sudo service mongod {start|stop|restart|reload|force-reload|status}
ps aux | grep 'mongo'
tail /var/log/mongodb/mongod.log

/usr/bin/mongod --config /home/gordon/Workspace/Boxtrkr/mongodb.conf.yml

mongodb.conf.yml

net:
   bindIp: 127.0.0.1
   port: 27018
storage:
   dbPath: "/home/gordon/workspace/Boxtrkr/data/db"
   smallFiles: true
   journal:
      enabled: true
processManagement:
   fork: true
systemLog:
   destination: file
   path: "/home/gordon/workspace/Boxtrkr/logs/mongodb.log"
   quiet: true
   logAppend: true
   traceAllExceptions: true





from pymongo import Connection
connection = Connection(
    '127.0.0.1',
    27018
)

db = connection.boxtracker


MongoDB supervisor config
[program:mongodb]
command=/opt/mongodb/bin/mongod --dbpath /storage/mongodb_data --rest
directory=/opt/mongodb
user=root
autostart=false
