#!/bin/bash
###################################################################
# Spark Installation Script
# Spark version : 2.1.0
# Scala version : 2.12.1
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract scala to /opt/scala
###################################################################
tar xzf $SCALA_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $SCALA_DIR


###################################################################
# Extract spark to /opt/spark
###################################################################
tar xzf $SPARK_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $SPARK_DIR


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

## SCALA env variables
export SCALA_HOME=$SCALA_DIR
export PATH=\$SCALA_HOME/bin:\$PATH

## SPARK env variables
export SPARK_HOME=$SPARK_DIR
export PATH=\$SPARK_HOME/bin:\$SPARK_HOME/sbin:\$PATH
EOT

source .bashrc


###################################################################
# Configure Spark
###################################################################
# Create configuration file
cp $SPARK_DIR/conf/spark-env.sh.template $SPARK_DIR/conf/spark-env.sh
cp $SPARK_DIR/conf/spark-defaults.conf.template $SPARK_DIR/conf/spark-defaults.conf

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################

