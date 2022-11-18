#!/bin/bash

NAME=$1

ID=$(hcloud server list -o columns=id,name | grep $NAME | cut -d " " -f1)
if [ -z "$ID" ]; then
  echo "No server found with this name: "$NAME
  exit 1
fi

hcloud server delete $ID
echo server removed