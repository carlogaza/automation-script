#!/bin/bash
###################################################################
# Common Tools Installation Script
# Tools : Oracle Java, sshpass
###################################################################


###################################################################
# Copy environtment variable to opt and give access to all user
###################################################################
cp /root/postinstall/script/install-env.sh /opt/
chmod 777 /opt/install-env.sh
source /opt/install-env.sh


###################################################################
# Install sshpass
###################################################################
rpm -Uvh $INSTALLER_DIR/sshpass-1.05-5.el7.x86_64.rpm


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
rpm -Uvh $INSTALLER_DIR/jdk-8u121-linux-x64.rpm

su - hduser <<'EOF'
source /opt/install-env.sh
cat <<EOT >> .bashrc

## JAVA env variables
export JAVA_HOME=$JAVA_DIR
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
tar xzf $MAVEN_INS -C $INSTALLATION_DIR/
chown -R hduser:hadoop $MAVEN_DIR

su - hduser <<'EOF'
source /opt/install-env.sh
cat <<EOT >> .bashrc

## MAVEN env variables
export M2_HOME=$MAVEN_DIR
export PATH=\$M2_HOME/bin:\$PATH
EOT

source .bash_profile
EOF
