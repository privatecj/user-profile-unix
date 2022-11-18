#!/bin/bash

sudo snap install code --classic
sudo snap install sublime-text --classic
sudo snap install sublime-merge --classic

sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget

# Install All Editors
sudo apt update
sudo apt install -y meld
