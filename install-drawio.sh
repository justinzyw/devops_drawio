#!/bin/bash

# Fetch the variables
. parm.txt

# function to get the current time formatted
currentTime()
{
  date +"%Y-%m-%d %H:%M:%S";
}

sudo docker service scale devops-drawio=0

echo ---$(currentTime)---populate the volumes---
#to zip, use: sudo tar zcvf devops_drawio_volume.tar.gz /var/nfs/volumes/devops_drawio*
#sudo tar zxvf devops_drawio_volume.tar.gz -C /

echo ---$(currentTime)---create drawio service---
sudo docker service create -d \
--publish $DRAWIO_HTTP_PORT:8080 \
--publish $DRAWIO_HTTPS_PORT:8443 \
--name devops-drawio \
--network $NETWORK_NAME \
--replicas 1 \
--constraint 'node.role == manager' \
$DRAWIO_IMAGE

sudo docker service scale devops-drawio=1
