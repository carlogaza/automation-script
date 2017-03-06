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
# Generate key SSH for Hadoop User
###################################################################
su - hduser <<'EOF'
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
EOF


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


###################################################################
# Uninstall OpenJDK
###################################################################
yum -y remove java*


###################################################################
# Install Oracle Java
###################################################################
rpm -Uvh /root/postinstall/apps/jdk-8u121-linux-x64.rpm

su - hduser <<'EOF'
cat <<EOT >> .bashrc

## JAVA env variables
export JAVA_HOME=/usr/java/default
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/jre/lib:\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar
EOT

source .bashrc
EOF


###################################################################
# Copy init script to root home and hadoop home
###################################################################
cp /root/postinstall/script/init-first-boot.sh /root/
cp /root/init-first-boot.sh /home/hduser/
chown hduser:hadoop /home/hduser/init-first-boot.sh


###################################################################
# Install Apache Maven
###################################################################
cd /root/postinstall/apps
tar xzf apache-maven-3.3.9-bin.tar.gz -C /opt/

su - hduser <<'EOF'
cat <<EOT >> .bashrc

## MAVEN env variables
export M2_HOME=/opt/apache-maven-3.3.9
export PATH=\$M2_HOME/bin:\$PATH
EOT

source .bash_profile
EOF
