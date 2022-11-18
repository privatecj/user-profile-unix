#!/bin/bash

sudo apt update
sudo apt-get install -y unattended-upgrades
sudo apt-get -y install build-essential git autoconf automake libtool bison

pushd /tmp
git clone https://github.com/satori-com/tcpkali.git
cd tcpkali/
test -f configure || autoreconf -iv
./configure
make
sudo make install
popd