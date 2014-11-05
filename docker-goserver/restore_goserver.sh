#!/bin/sh

# fetch IP address of docker container
IP_ADDRESS=`docker inspect $1 | grep "IPAddress" | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}

# copy backup file from local filesystem to container && decompress
echo "Copying backup files to Go Server docker container..."
scp -i vagrant_key goserver_backup.tar.gz vagrant@${IP_ADDRESS}:/home/vagrant/goserver_backup.tar.gz

# decompress backup file
echo "Decompressing backup files..."
ssh -i vagrant_key vagrant@${IP_ADDRESS} tar -C /home/vagrant --overwrite -xzvf goserver_backup.tar.gz .

# stop go server
echo "Stopping Go Server..."
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo /etc/init.d/go-server stop

# decompress go server backup files and put in correct folders
echo "Deploy backup files..."
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/db.zip -d /var/lib/go-server/db/h2db/
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/config-dir.zip -d /etc/go/
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo unzip -o /home/vagrant/config-repo.zip -d /var/lib/go-server/db/config.git/

docker exec $1 sudo chown -R go:go /etc/go/
docker exec $1 sudo chown -R go:go /var/lib/go-server/db/

# start go server again
echo "Restart Go Server..."
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo /etc/init.d/go-server start

echo "Done."

