#!/bin/bash

cp -p /etc/ssh/sshd_config{,.$(date +%Y%m%d-%H%M)}
sshd -t
sdiff -s /etc/ssh/sshd_config{,.20210511-1159}
groupadd sftponly
newgrp sftponly
useradd darthsftp -s /sbin/nologin -G sftponly
getent passwd darthsftp
systemctl restart sshd
su -s /bin/bash -c 'touch /home/darthsftp/testfile.txt' darthsftp
cd /home/darthsftp/
mkdir .ssh
cd .ssh/
ssh-keygen -f darthsftp
tail -1 darthsftp.pub >> authorized_keys
chown darthsftp. -R /home/darthsftp/.ssh
chown root:root /home/darthsftp
chmod 755 /home/darthsftp
sftp -P -i /home/darthsftp/.ssh/darthsftp darthsftp@127.0.0.1

#This is a test to do the first commit of 01072023-lee
#This is a test to do a merge of 01072023-lee to 29062023-lee
