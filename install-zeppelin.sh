#!/bin/bash
###################################################################
# Zeppelin Installation Script
# Zeppelin version : 0.7.0
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract zeppelin to /opt/zeppelin
###################################################################
tar xzf $ZEPPELIN_INS -C $INSTALLATION_DIR


###################################################################
# Configure Zeppelin
###################################################################
cp $ZEPPELIN_DIR/conf/zeppelin-env.sh.template $ZEPPELIN_DIR/conf/zeppelin-env.sh
cp $ZEPPELIN_DIR/conf/zeppelin-site.xml.template $ZEPPELIN_DIR/conf/zeppelin-site.xml
chown -R hduser:hadoop $ZEPPELIN_DIR


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

## ZEPPELIN env variables
export ZEPPELIN_HOME=$ZEPPELIN_DIR
export PATH=\$ZEPPELIN_HOME/bin:\$PATH
EOT

source .bashrc

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
