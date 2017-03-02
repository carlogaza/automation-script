#!/bin/bash
###################################################################
# First Boot Initialization Script
# Desc : Run configuration some application on first boot.
# note : Run this script as hadoop user (hduser).
###################################################################


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
# su - hduser <<'EOF'


###################################################################
# Create HDFS directory for Hive
###################################################################
echo "--- Starting DFS ..."
start-dfs.sh
echo "--- Creating directory for hive ..."
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -chmod g+w /user/hive/warehouse
hadoop fs -mkdir -p /tmp
hadoop fs -chmod g+w /tmp
echo "--- Creating directory for flume ..."
hadoop fs -mkdir -p /user/flume
hadoop fs -chmod g+w /user/flume
echo "--- Stoping DFS ..."
stop-dfs.sh


###################################################################
# Initialization Apache Derby Database
###################################################################
echo "--- Initialization schematool for hive ..."
schematool -initSchema -dbType derby


# EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
