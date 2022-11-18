#!/bin/bash

sudo apt install -y tilix

echo "
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
" > ~/.bashrc
