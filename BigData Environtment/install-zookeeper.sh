#!/bin/bash
###################################################################
# ZooKeeper Installation Script
# ZooKeeper version : 3.4.9
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract zookeeper to /opt/zookeeper
###################################################################
tar xzf $ZOOKEEPER_INS -C $INSTALLATION_DIR


###################################################################
# Configure ZooKeeper
###################################################################
mkdir -p $ZOOKEEPER_DATA
cat <<EOT >> $ZOOKEEPER_DIR/conf/zoo.cfg
tickTime = 2000
dataDir = $ZOOKEEPER_DATA
clientPort = 2181
initLimit = 5
syncLimit = 2
EOT
chown -R hduser:hadoop $ZOOKEEPER_DIR
chown -R hduser:hadoop $ZOOKEEPER_DATA


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## ZOOKEEPER env variables
export ZOOKEEPER_HOME=$ZOOKEEPER_DIR
export PATH=\$ZOOKEEPER_HOME/bin:\$PATH
EOT

source .bashrc

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
