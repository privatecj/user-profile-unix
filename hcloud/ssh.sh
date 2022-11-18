#!/bin/bash

NAME=$1

IP=$(hcloud server list -o columns=ipv4,name | grep $NAME | cut -d " " -f1)
if [ -z "$IP" ]; then
  echo "No server found with this name: "$NAME
  exit 1
fi

ssh -o StrictHostKeyChecking=no cj@$IP
