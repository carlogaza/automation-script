#!/bin/bash
###################################################################
# ZooKeeper Installation Script
# ZooKeeper version : 3.4.9
###################################################################


###################################################################
# Extract zookeeper to /opt/zookeeper
###################################################################
cd /root/postinstall/apps
tar xzf zookeeper-3.4.9.tar.gz -C /opt/


###################################################################
# Configure ZooKeeper
###################################################################
mkdir /opt/zookeeper-data
cat <<EOT >> /opt/zookeeper-3.4.9/conf/zoo.cfg
tickTime = 2000
dataDir = /opt/zookeeper-data
clientPort = 2181
initLimit = 5
syncLimit = 2
EOT
chown -R hduser:hadoop /opt/zookeeper-3.4.9/
chown -R hduser:hadoop /opt/zookeeper-data/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## ZOOKEEPER env variables
export ZOOKEEPER_HOME=/opt/zookeeper-3.4.9
export PATH=\$PATH:\$ZOOKEEPER_HOME/bin
EOT

source .bash_profile

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
