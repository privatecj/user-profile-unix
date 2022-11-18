#!/bin/bash

docker run \
-d \
--restart on-failure \
-p 3306:3306 \
-e MYSQL_DATABASE=default \
-e MYSQL_USER=cj \
-e MYSQL_PASSWORD=open \
-e MYSQL_ROOT_PASSWORD=change-me \
--name=mysql mysql/mysql-server:latest


