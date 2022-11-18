#!/bin/bash

# https://github.com/5cr1pt/GitCracken/pull/79

pushd /tmp

wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb


git clone https://github.com/PMExtra/GitCracken
cd GitCracken/GitCracken
yarn install
yarn build
node dist/bin/gitcracken.js patcher


popd
