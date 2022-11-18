#!/bin/bash

export NEWUSER=cj;


function install_absolute_essential(){
    echo "==================================== install_absolute_essential() ===================================="
    sudo apt update
    sudo apt-get install -y wget unzip dos2unix mosh vsftpd neofetch openssh-server
}

function create_user(){
    echo "==================================== create_user_cj() ===================================="
    echo "Creating User $NEWUSER. Who am I: "$USER    
    sudo useradd $NEWUSER -s /bin/bash -m -g sudo
    echo "$NEWUSER:code" > /tmp/pass123
    sudo chpasswd < /tmp/pass123
    rm /tmp/pass123
    sudo adduser $NEWUSER sudo
    echo "$NEWUSER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    sudo service sshd restart
}


function ssh_config(){
    # Enable password authentication for ssh
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    echo "MaxAuthTries 50" | sudo tee -a /etc/ssh/sshd_config
}

function configure_ssh_ftp(){
    echo "==================================== configure_ssh_ftp() ===================================="
    echo "Configuring SSH and FTP. Who am I: "$USER
    echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
    sudo systemctl enable vsftpd
    sudo systemctl start vsftpd
    sudo systemctl restart vsftpd.service
    sudo systemctl status vsftpd.service
}

function setup_dir_layout(){
    mkdir -p /home/$NEWUSER/mydrive/gsync
    mkdir -p /home/$NEWUSER/mydrive/dsync
    mkdir -p /home/$NEWUSER/mydrive/apps-data
    mkdir -p /home/$NEWUSER/mydrive/user-apps
    mkdir -p /home/$NEWUSER/mydrive/user-profile
    mkdir -p /home/$NEWUSER/mydrive/tmp
    mkdir -p /home/$NEWUSER/mydrive/projects/personal
    mkdir -p /home/$NEWUSER/mydrive/projects/official
    mkdir -p /home/$NEWUSER/mydrive/projects/experimental
    mkdir -p /home/$NEWUSER/mydrive/projects/checkouts
    chown -R $NEWUSER /home/$NEWUSER
}

function download_profile(){
    cd /home/$NEWUSER/mydrive;
    pwd;
    rm -rf user-profile
    wget -O user-profile.zip https://www.dropbox.com/sh/p7gylx6vwupq5u3/AACcQSAO_EYXtJgRB_mHdP6ha?dl=1;
    unzip -o user-profile.zip -d user-profile;
    rm -f user-profile.zip
    cd install;
    find /home/$NEWUSER/mydrive/user-profile -type f -exec dos2unix {} \;
    chown -R $NEWUSER /home/$NEWUSER
    pwd
}

function install_profile(){
    cd /home/$NEWUSER/mydrive/user-profile
    ./install.sh
}

install_absolute_essential;
create_user;
ssh_config;
configure_ssh_ftp;
setup_dir_layout;
download_profile;
install_profile;
