#!/bin/bash
###################################################################
# ZooKeeper Installation Script
# ZooKeeper version : 3.4.9
###################################################################


###################################################################
# Add new user for ZooKeeper
###################################################################
useradd -d /opt/zookeeper -G hadoop zookeeper
echo zookeeper:zookeeper | chpasswd


###################################################################
# Extract zookeeper to /opt/zookeeper
###################################################################
cd /root/postinstall/apps
tar xzf zookeeper-3.4.9.tar.gz
mv zookeeper-3.4.9/* /opt/zookeeper/


###################################################################
# Configure ZooKeeper
###################################################################
mkdir /opt/zookeeper/data
cat <<EOT >> /opt/zookeeper/conf/zoo.cfg
tickTime = 2000
dataDir = /opt/zookeeper/data
clientPort = 2181
initLimit = 5
syncLimit = 2
EOT
chown -R zookeeper:hadoop /opt/zookeeper/
