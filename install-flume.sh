#!/bin/bash
###################################################################
# Flume Installation Script
# Flume version : 1.7.0
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract flume to /opt/flume
###################################################################
tar xzf $FLUME_INS -C $INSTALLATION_DIR


###################################################################
# Configure Flume
###################################################################
cp $FLUME_DIR/conf/flume-env.sh.template $FLUME_DIR/conf/flume-env.sh
cp $FLUME_DIR/conf/flume-conf.properties.template $FLUME_DIR/conf/flume-conf.properties
sed -i '/export JAVA_HOME=/a export JAVA_HOME=$JAVA_DIR' $FLUME_DIR/conf/flume-env.sh
cp $INSTALLER_DIR/libs/flume-sources-1.0-SNAPSHOT.jar $FLUME_DIR/lib
cp $INSTALLER_DIR/appconfig/flume-twitter.conf $FLUME_DIR/conf
chown -R hduser:hadoop $FLUME_DIR


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

## FLUME env variables
export FLUME_HOME=$FLUME_DIR
export PATH=\$FLUME_HOME/bin:\$PATH
export CLASSPATH=\$FLUME_HOME/lib/*:\$CLASSPATH
EOT

source .bashrc

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
