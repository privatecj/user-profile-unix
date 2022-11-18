#!/bin/bash

pushd /tmp

mkdir -p ~/mydrive/user-apps/datagrid
cd ~/mydrive/user-apps/datagrid
wget https://download.jetbrains.com/datagrip/datagrip-2022.2.5.tar.gz
tar xvf datagrip-2022.2.5.tar.gz
mv DataGrip-2022.2.5 datagrip
mv datagrip/* .
rm datagrip-2022.2.5.tar.gz
rmdir datagrip
echo "-javaagent:/home/cj/mydrive/user-apps/jetbra/ja-netfilter.jar=jetbrains" >> ~/mydrive/user-apps/datagrid/bin/datagrip64.vmoptions

popd