#!/bin/bash
pushd /tmp

sudo apt-get update
sudo apt-get install -y --no-install-recommends build-essential autoconf automake libtool bison flex ncurses-dev libopenmpi-dev

wget https://github.com/satori-com/tcpkali/releases/download/v1.1.1/tcpkali-1.1.1.tar.gz
tar xvf tcpkali-1.1.1.tar.gz
cd tcpkali-1.1.1
test -f configure || autoreconf -iv
./configure
sed -i 's/sys\/sysctl.h/linux\/sysctl.h/g' src/tcpkali_syslimits.c
make 
sudo make install

popd