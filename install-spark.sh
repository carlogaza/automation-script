#!/bin/bash
###################################################################
# Spark Installation Script
# Spark version : 2.1.0
# Scala version : 2.12.1
###################################################################


###################################################################
# Extract scala to /opt/scala
###################################################################
cd /root/postinstall/apps
tar xvf scala-2.12.1.tgz -C /opt/
chown -R hduser:hadoop /opt/scala-2.12.1/


###################################################################
# Extract spark to /opt/spark
###################################################################
cd /root/postinstall/apps
tar xvf spark-2.1.0-bin-hadoop2.7.tgz -C /opt/
chown -R hduser:hadoop /opt/spark-2.1.0-bin-hadoop2.7/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## SCALA env variables
export SCALA_HOME=/opt/scala-2.12.1/
export PATH=\$SCALA_HOME/bin:\$PATH

## SPARK env variables
export SPARK_HOME=/opt/scala-2.12.1/
export PATH=\$SPARK_HOME/bin:\$SPARK_HOME/sbin:\$PATH
EOT

source .bashrc


###################################################################
# Configure Spark
###################################################################
# Create configuration file
cp /opt/spark-2.1.0-bin-hadoop2.7/spark-env.sh.template /opt/spark-2.1.0-bin-hadoop2.7/spark-env.sh
cp /opt/spark-2.1.0-bin-hadoop2.7/spark-defaults.conf.template /opt/spark-2.1.0-bin-hadoop2.7/spark-defaults.conf

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################

