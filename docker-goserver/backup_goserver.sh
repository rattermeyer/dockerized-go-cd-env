#!/bin/sh

# fetch IP address of docker container
IP_ADDRESS=`docker inspect $1 | grep "IPAddress" | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}

# trigger go server backup via API
echo "Trigger backup on Go Server..."
curl -d "" http://${IP_ADDRESS}:8153/go/api/admin/start_backup

# compress backup files & delete backup folder (so it contains only 1 backup directory every time the backup is triggered)
echo "Compressing files..."
ssh -i vagrant_key vagrant@${IP_ADDRESS} tar -C /var/lib/go-server/artifacts/serverBackups/backup* -czvf /home/vagrant/goserver_backup.tar.gz .
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo rm -r /var/lib/go-server/artifacts/serverBackups/
ssh -i vagrant_key vagrant@${IP_ADDRESS} ls -la /home/vagrant

# copy backup file from container to local filesystem
echo "Copy to host..."
scp -i vagrant_key vagrant@${IP_ADDRESS}:/home/vagrant/goserver_backup.tar.gz .
#docker cp $1:/tmp/goserver_backup.tar.gz .

echo "Done."
