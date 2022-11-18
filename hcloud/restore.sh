#!/bin/bash

NAME=$1
CURRENT_IMAGE_ID=$(hcloud image list -o columns=id,description | grep "snapshot" | tail -1 | cut -d " " -f1)

./create.sh $NAME $CURRENT_IMAGE_ID