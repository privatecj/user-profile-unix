#!/bin/bash

sudo snap install nextcloud
sudo nextcloud.manual-install admin adminadmin
sudo nextcloud.occ config:system:set trusted_domains 1 --value=$(curl ipinfo.io/ip)
sudo nextcloud.occ config:system:get trusted_domains

sudo snap set nextcloud ports.http=5080
sudo systemctl restart snap.nextcloud.apache.service