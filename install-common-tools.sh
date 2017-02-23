#!/bin/bash
###################################################################
# Common Tools Installation Script
# Tools : Oracle Java, sshpass
###################################################################


###################################################################
# Install sshpass
###################################################################
rpm -Uvh /root/postinstall/apps/sshpass-1.05-5.el7.x86_64.rpm


###################################################################
# Uninstall OpenJDK
###################################################################
yum -y remove java*


###################################################################
# Install Oracle Java
###################################################################
rpm -Uvh /root/postinstall/apps/jdk-8u121-linux-x64.rpm


###################################################################
# Disable SSH Host Key Checking on localhost 
###################################################################
cat <<EOT >>/etc/ssh/ssh_config

Host localhost
  StrictHostKeyChecking no

Host 127.0.0.1
  StrictHostKeyChecking no

Host 0.0.0.0
  StrictHostKeyChecking no
EOT
