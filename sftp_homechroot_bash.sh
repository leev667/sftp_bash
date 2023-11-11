#!/bin/bash

read -p "Enter sftp user name: " user_name

#Variables
SHELL="/sbin/nologin"
USER="$user_name"
SFTPGROUP="sftponly"

# Create the user
useradd -s $SHELL -G $SFTPGROUP $USER

#Generate Keys for user
mkdir -p /home/$USER/.ssh
ssh-keygen -b 4096 -f /home/$USER/.ssh/${USER}.pem

#Copy public key
cat /home/$USER/.ssh/${USER}.pem.pub >> /home/$USER/.ssh/authorized_keys

#Make a uploads directory
mkdir -p /home/$USER/uploads
chown ${USER}: /home/$USER/uploads

#Change perms of home users dir to root and rwx
chown root: /home/$USER/
chmod 755 /home/$USER/
