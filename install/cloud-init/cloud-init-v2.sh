#!/bin/bash
export NEWUSER=cj;

touch /tmp/cloud-init-running.txt

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

function wait_until_cloud_finish_check_for_user_bash_profile(){
        echo '
until [ ! -f /tmp/cloud-init-running.txt ]
do
    clear;
    echo "CLOUD INIT still running $(date +"%r")"
    sleep 1
done
    ' >> "/home/$NEWUSER/.bashrc"
    chown -R $NEWUSER "/home/$NEWUSER/.bashrc"
    echo '
until [ ! -f /tmp/cloud-init-running.txt ]
do
    clear;
    echo "CLOUD INIT still running $(date +"%r")"
    sleep 1
done
    ' >> "/home/$NEWUSER/.bash_profile"
    chown -R $NEWUSER "/home/$NEWUSER/.bash_profile"
}

function install_essential(){
    echo "==================================== install_absolute_essential() ===================================="
    sudo apt update
    sudo apt-get install unattended-upgrades

    # install file tools
    sudo apt-get install -y zip unzip unrar-free tar dos2unix file

    # install internet tools
    sudo apt-get install -y wget curl aria2 speedtest-cli

    # install network tools
    sudo apt-get install -y mosh vsftpd openssh-server iperf net-tools

    # install dev tools
    sudo apt-get install -y neofetch git podman 

    # install system toolss
    sudo apt install -y snap htop btop
    sudo snap install starship
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
    mkdir -p /home/$NEWUSER/mydrive/tmp
    mkdir -p /home/$NEWUSER/mydrive/projects/personal
    mkdir -p /home/$NEWUSER/mydrive/projects/official
    mkdir -p /home/$NEWUSER/mydrive/projects/experimental
    mkdir -p /home/$NEWUSER/mydrive/projects/checkouts
    chown -R $NEWUSER /home/$NEWUSER
}

function download_profile(){
    cd /home/$NEWUSER/mydrive;
    rm -rf user-profile-unix
    git clone https://github.com/privatecj/user-profile-unix.git
    mv user-profile-unix user-profile;
    cd user-profile;
    find . -type f -exec dos2unix {} \;
    chown -R $NEWUSER /home/$NEWUSER
}

function install_profile(){
    cd /home/$NEWUSER/mydrive/user-profile
    sudo -H -u cj bash ./install.sh
}

create_user;
wait_until_cloud_finish_check_for_user_bash_profile;
install_essential;
ssh_config;
configure_ssh_ftp;
setup_dir_layout;
download_profile;
install_profile;

rm /tmp/cloud-init-running.txt
touch /tmp/cloud-init-finished.txt