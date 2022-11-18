#!/bin/bash

NAME=$1

ID=$(hcloud server list -o columns=id,name | grep $NAME | cut -d " " -f1)
if [ -z "$ID" ]; then
  echo "No server found with this id: "$NAME
  exit 1
fi


CURRENT_IMAGE_ID=$(hcloud image list -o columns=id,description | grep "snapshot" | tail -1 | cut -d " " -f1)


echo stoping server
./poweroff.sh $NAME

echo creating snapshot
hcloud server create-image --type=snapshot --description $NAME-snapshot $ID


if ! [ -z "$ID" ]; then
	echo deleting old snapshot
	hcloud image delete $CURRENT_IMAGE_ID
fi


echo starting server
./poweron.sh $NAME

