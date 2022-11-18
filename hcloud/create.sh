#!/bin/bash

NAME=$1
SERVER_TYPE=cpx21
DEFAULT_IMAGE_ID=15512617   # ubuntu 20.04
IMAGE_ID="${2:-$DEFAULT_IMAGE_ID}"


if hcloud server list -o columns=name | grep -q $NAME; then
  echo "already a server is running with the same name"
  exit 1
fi


echo "Creating new server"
hcloud server create --name $NAME --image $IMAGE_ID --type $SERVER_TYPE