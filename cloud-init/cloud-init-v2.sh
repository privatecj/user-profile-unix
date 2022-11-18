#!/bin/bash
export NEWUSER=cj;

touch /tmp/cloud-init-running.txt
chmod 777 /var/log/cloud-init-output.log

function create_user(){
    log "Creating User $NEWUSER"

    sudo useradd $NEWUSER -s /bin/bash -m -g sudo
    echo "$NEWUSER:code" > /tmp/pass123
    sudo chpasswd < /tmp/pass123
    rm /tmp/pass123
    sudo adduser $NEWUSER sudo
    echo "$NEWUSER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    sudo service sshd restart
}

function init_bash_files(){
    log "Initilizing bash files for User $NEWUSER"

    export NEWUSER=cj;
    rm /home/$NEWUSER/.bashrc
    rm /home/$NEWUSER/.bash_profile
    rm /home/$NEWUSER/.profile
    touch /home/$NEWUSER/.bashrc
    touch /home/$NEWUSER/.bash_profile
    touch /home/$NEWUSER/.profile

    echo '
    if [ -f ~/.bashrc ];
    then 
        .  ~/.bashrc; 
    fi 
    export PATH
    ' >> /home/$NEWUSER/.bash_profile

    echo '
    until [ ! -f /tmp/cloud-init-running.txt ]
    do
        clear;
        echo "========================================================"
        echo "CLOUD INIT still running $(date +"%r")"
        echo "========================================================"
        echo ""
        echo ""
        tail -n 60 /var/log/cloud-init-output.log
        sleep 3
    done

    if test -f "/tmp/cloud-init-finished.txt"; then
        rm -f /tmp/cloud-init-finished.txt
        source ~/.bashrc
    fi
    ' >> "/home/$NEWUSER/.bashrc"
}

function install_essential(){
    log "updating apt cache"    
    sudo apt-get update

    log "upgrading distro"
    sudo apt-get install unattended-upgrades

    # install file tools
    log "installing file tools"
    sudo apt-get install -y zip unzip unrar-free tar dos2unix file

    # install internet tools
    log "installing internet tools"
    sudo apt-get install -y wget curl aria2 speedtest-cli

    # install network tools
    log "installing network tools"
    sudo apt-get install -y mosh vsftpd openssh-server iperf net-tools

    # install dev tools
    log "installing dev tools"
    sudo apt-get install -y neofetch git podman 

    # install system tools
    log "installing system tools"
    sudo apt install -y snapd htop btop
    sudo snap install starship
}

function ssh_config(){
    log "configuring ssh"
    # Enable password authentication for ssh
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    echo "MaxAuthTries 50" | sudo tee -a /etc/ssh/sshd_config
}

function configure_ssh_ftp(){
    log "configuring ftp"

    echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
    sudo systemctl enable vsftpd
    sudo systemctl start vsftpd
    sudo systemctl restart vsftpd.service
    sudo systemctl status vsftpd.service
}

function setup_dir_layout(){
    log "creating directory layout"

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
    log "installing user profile"

    cd /home/$NEWUSER/mydrive/user-profile
    sudo -H -u cj bash ./install.sh
}

function install_docker(){
    log "installing docker"

    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo groupadd docker
    sudo usermod -aG docker $NEWUSER
}

function install_java(){
    log "installing java"

    curl -s "https://get.sdkman.io" -o get-sdkman.sh
    bash get-sdkman.sh
    source "/home/$USER/.sdkman/bin/sdkman-init.sh"
    sdk i java 17.0.5-zulu
    sdk i maven
    sdk i gradle
}

function log(){
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<<<<<<<<<<<<<<<"
    echo ""
}

create_user;
init_bash_files;
install_essential;
ssh_config;
configure_ssh_ftp;
setup_dir_layout;
download_profile;
install_profile;
install_docker;
install_java;

rm /tmp/cloud-init-running.txt
touch /tmp/cloud-init-finished.txt
chown -R $NEWUSER /tmp/cloud-init-finished.txt