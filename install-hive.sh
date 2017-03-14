#!/bin/bash
###################################################################
# Hive Installation Script
# Hive version : 2.1.1
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract hive to /opt/
###################################################################
tar xzf $HIVE_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $HIVE_DIR


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

## HIVE env variables
export HIVE_HOME=$HIVE_DIR
export PATH=\$HIVE_HOME/bin:\$PATH
EOT

source .bashrc


###################################################################
# Configure Hive
###################################################################
sed -i '/# Default to use 256MB/i \ ' $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i # HADOOP directory' $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i export HADOOP_HOME=$HADOOP_DIR' $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i \ ' $HIVE_DIR/bin/hive-config.sh


###################################################################
# Create HDFS directory for Hive
# note : Moved to init script, because cannot run on postinstall
###################################################################
: '
start-dfs.sh
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -mkdir -p /tmp
hadoop fs -chmod g+w /user/hive/warehouse
hadoop fs -chmod g+w /tmp
'

###################################################################
# Initialization Apache Derby Database
# note : Moved to init script, because cannot run on postinstall
###################################################################
: '
schematool -initSchema -dbType derby
'


EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
