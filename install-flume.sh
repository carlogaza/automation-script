#!/bin/bash
###################################################################
# Flume Installation Script
# Flume version : 1.7.0
###################################################################


###################################################################
# Extract flume to /opt/flume
###################################################################
cd /root/postinstall/apps
tar xzf apache-flume-1.7.0-bin.tar.gz -C /opt/


###################################################################
# Configure Flume
###################################################################
cp /opt/apache-flume-1.7.0-bin/flume-env.sh.template /opt/apache-flume-1.7.0-bin/flume-env.sh
cp /opt/apache-flume-1.7.0-bin/flume-conf.properties.template /opt/apache-flume-1.7.0-bin/flume-conf.properties
sed -i '/export JAVA_HOME=/a export JAVA_HOME=/usr/java/default' /opt/apache-flume-1.7.0-bin/
cp /root/postinstall/apps/libs/flume-sources-1.0-SNAPSHOT.jar /opt/apache-flume-1.7.0-bin/lib
chown -R hduser:hadoop /opt/apache-flume-1.7.0-bin/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## FLUME env variables
export FLUME_HOME=/opt/apache-flume-1.7.0-bin
export PATH=\$PATH:\$FLUME_HOME/bin
export CLASSPATH=\$CLASSPATH:\$FLUME_HOME/lib/*
EOT

source .bash_profile

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################