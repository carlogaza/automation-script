#!/bin/bash
###################################################################
# Hadoop Installation Script
# Hadoop version : 2.7.3
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Change hostname to master
###################################################################
hostnamectl set-hostname master


###################################################################
# Restart SSH Service
# note : not working in chroot environment
###################################################################
systemctl restart sshd


###################################################################
# Add new user for hadoop
# note : user was auto add in instalation
###################################################################
: '
groupadd hadoop
useradd -d /opt/hadoop -G hadoop hduser
echo hduser:hadoop | chpasswd
'


###################################################################
# Extract hadoop to /opt/hadoop
###################################################################
tar xzf $HADOOP_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $HADOOP_DIR


###################################################################
# Make folder datanode and namenode
###################################################################
mkdir -p $NAMENODE_DIR
mkdir -p $DATANODE_DIR
chown -R hduser:hadoop $NAMENODE_DIR
chown -R hduser:hadoop $DATANODE_DIR


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

## HADOOP env variables
export HADOOP_HOME=$HADOOP_DIR
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_YARN_HOME=\$HADOOP_HOME
export HADOOP_OPTS="-Djava.library.path=\$HADOOP_HOME/lib/native"
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native
export PATH=\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin:\$PATH
EOT

source .bashrc


###################################################################
# Configure Hadoop
###################################################################
# Backup configuration file
cp $HADOOP_DIR/etc/hadoop/core-site.xml $HADOOP_DIR/etc/hadoop/core-site.xml.bak
cp $HADOOP_DIR/etc/hadoop/hdfs-site.xml $HADOOP_DIR/etc/hadoop/hdfs-site.xml.bak
cp $HADOOP_DIR/etc/hadoop/mapred-site.xml.template $HADOOP_DIR/etc/hadoop/mapred-site.xml
cp $HADOOP_DIR/etc/hadoop/yarn-site.xml $HADOOP_DIR/etc/hadoop/yarn-site.xml.bak

# Modify corn-site hadoop
sed -i '/<\/configuration>/i \\t<property>' $HADOOP_DIR/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t\t<name>fs.defaultFS<\/name>' $HADOOP_DIR/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t\t<value>hdfs://localhost:9000/<\/value>' $HADOOP_DIR/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HADOOP_DIR/etc/hadoop/core-site.xml

# Modify hdfs-site hadoop
sed -i '/<\/configuration>/i \\t<property>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<name>dfs.data.dir<\/name>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<value>file://'$DATANODE_DIR'<\/value>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<property>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<name>dfs.name.dir<\/name>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<value>file://'$NAMENODE_DIR'<\/value>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HADOOP_DIR/etc/hadoop/hdfs-site.xml

# Modify mapred-site hadoop
sed -i '/<\/configuration>/i \\t<property>' $HADOOP_DIR/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t\t<name>mapreduce.framework.name<\/name>' $HADOOP_DIR/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t\t<value>yarn<\/value>' $HADOOP_DIR/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HADOOP_DIR/etc/hadoop/mapred-site.xml

# Modify yarn-site hadoop
sed -i '/<\/configuration>/i \\t<property>' $HADOOP_DIR/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t\t<name>yarn.nodemanager.aux-services<\/name>' $HADOOP_DIR/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t\t<value>mapreduce_shuffle<\/value>' $HADOOP_DIR/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HADOOP_DIR/etc/hadoop/yarn-site.xml

###################################################################
# Format Hadoop Namenode
###################################################################
hdfs namenode -format

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################


