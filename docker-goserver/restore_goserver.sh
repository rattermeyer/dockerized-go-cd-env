#!/bin/sh

# fetch IP address of docker container
IP_ADDRESS=`docker inspect $1 | grep "IPAddress" | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}

# trigger go server backup via API
curl -d "" http://${IP_ADDRESS}:8153/go/api/admin/start_backup

# copy backup file from local filesystem to container && decompress
scp -i vagrant_key goserver_backup.tar.gz vagrant@${IP_ADDRESS}:/home/vagrant/goserver_backup.tar.gz

# decompress backup file
ssh -i vagrant_key vagrant@${IP_ADDRESS} tar -C /home/vagrant --overwrite -xzvf goserver_backup.tar.gz .

# stop go server
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo /etc/init.d/go-server stop

# decompress go server backup files and put in correct folders
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/db.zip -d /var/lib/go-server/db/h2db/
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/config-dir.zip -d /etc/go/
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/config-repo.zip -d /var/lib/go-server/db/config.git/

docker exec $1 sudo chown -R go:go /etc/go/
docker exec $1 sudo chown -R go:go /var/lib/go-server/db/

# start go server again
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo /etc/init.d/go-server start


