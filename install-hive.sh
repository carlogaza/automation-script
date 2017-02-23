#!/bin/bash
###################################################################
# Pig Installation Script
# Pig version : 0.16.0
###################################################################


###################################################################
# Extract pig to /opt/pig
###################################################################
cd /root/postinstall/apps
tar xzf apache-hive-2.1.1-bin.tar.gz -C /opt/
chown -R hduser:hadoop /opt/apache-hive-2.1.1-bin/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## HIVE env variables
export HIVE_HOME=/opt/apache-hive-2.1.1-bin
export PATH=\$PATH:\$HIVE_HOME/bin
EOT

source .bash_profile


###################################################################
# Configure Hive
###################################################################
sed -i '/# Default to use 256MB/i \ ' /opt/apache-hive-2.1.1-bin/bin/hive-config.sh
sed -i '/# Default to use 256MB/i # HADOOP directory' /opt/apache-hive-2.1.1-bin/bin/hive-config.sh
sed -i '/# Default to use 256MB/i export HADOOP_HOME=/opt/hadoop-2.7.3' /opt/apache-hive-2.1.1-bin/bin/hive-config.sh
sed -i '/# Default to use 256MB/i \ ' /opt/apache-hive-2.1.1-bin/bin/hive-config.sh


###################################################################
# Create HDFS directory for Hive
###################################################################
start-dfs.sh
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -mkdir -p /tmp
hadoop fs -chmod g+w /user/hive/warehouse
hadoop fs -chmod g+w /tmp


###################################################################
# Initialization Apache Derby Database
###################################################################
schematool -initSchema -dbType derby


EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################