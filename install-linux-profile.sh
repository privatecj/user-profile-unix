#!/bin/bash


function install_u_profile(){
    echo "

    source /home/$NEWUSER/mydrive/user-profile/linux-init.sh

    " >> "/home/$NEWUSER/.bashrc"
        
    sudo chown -R $NEWUSER "/home/$NEWUSER/.bashrc"
        
    echo "

    if [ -f ~/.bashrc ]; then 
        source ~/.bashrc 
    fi

    " >> "/home/$NEWUSER/.bash_profile"
    sudo chown -R $NEWUSER "/home/$NEWUSER/.bash_profile"
        
    touch ~/.user-profile-installed
    echo "installed linux profile"
}


FILE=~/.user-profile-installed
if ! test -f "$FILE"; then
    echo "installing linux user profile"
    install_u_profile;
fi