#!/bin/bash
###################################################################
# Hadoop Installation Script
# Hadoop version : 2.7.3
###################################################################


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
###################################################################
groupadd hadoop
useradd -d /opt/hadoop -G hadoop hduser
echo hduser:hadoop | chpasswd


###################################################################
# Extract hadoop to /opt/hadoop
###################################################################
cd /root/postinstall/apps
tar xzf hadoop-2.7.3.tar.gz
mv hadoop-2.7.3/* /opt/hadoop/
chown -R hduser:hadoop /opt/hadoop/


###################################################################
# Make folder datanode and namenode
###################################################################
mkdir -p /opt/volume/namenode
mkdir -p /opt/volume/datanode
chown -R hduser:hadoop /opt/volume/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## JAVA env variables
export JAVA_HOME=/usr/java/default
export PATH=\$PATH:\$JAVA_HOME/bin
export CLASSPATH=.:\$JAVA_HOME/jre/lib:\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar

## HADOOP env variables
export HADOOP_HOME=/opt/hadoop
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_YARN_HOME=\$HADOOP_HOME
export HADOOP_OPTS="-Djava.library.path=\$HADOOP_HOME/lib/native"
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native
export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin
EOT

source .bash_profile

###################################################################
# Generate key SSH
###################################################################
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
sshpass -p hadoop /usr/bin/ssh-copy-id -o "StrictHostKeyChecking no" localhost


###################################################################
# Configure Hadoop
###################################################################
# Backup configuration file
cp /opt/hadoop/etc/hadoop/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml.bak
cp /opt/hadoop/etc/hadoop/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml.bak
cp /opt/hadoop/etc/hadoop/mapred-site.xml.template /opt/hadoop/etc/hadoop/mapred-site.xml
cp /opt/hadoop/etc/hadoop/yarn-site.xml /opt/hadoop/etc/hadoop/yarn-site.xml.bak

# Modify corn-site hadoop
sed -i '/<\/configuration>/i \\t<property>' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t\t<name>fs.defaultFS<\/name>' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t\t<value>hdfs://localhost:9000/<\/value>' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hadoop/etc/hadoop/core-site.xml

# Modify hdfs-site hadoop
sed -i '/<\/configuration>/i \\t<property>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<name>dfs.data.dir<\/name>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<value>file:///opt/volume/datanode<\/value>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<property>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<name>dfs.name.dir<\/name>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t\t<value>file:///opt/volume/namenode<\/value>' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hadoop/etc/hadoop/hdfs-site.xml

# Modify mapred-site hadoop
sed -i '/<\/configuration>/i \\t<property>' /opt/hadoop/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t\t<name>mapreduce.framework.name<\/name>' /opt/hadoop/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t\t<value>yarn<\/value>' /opt/hadoop/etc/hadoop/mapred-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hadoop/etc/hadoop/mapred-site.xml

# Modify yarn-site hadoop
sed -i '/<\/configuration>/i \\t<property>' /opt/hadoop/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t\t<name>yarn.nodemanager.aux-services<\/name>' /opt/hadoop/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t\t<value>mapreduce_shuffle<\/value>' /opt/hadoop/etc/hadoop/yarn-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hadoop/etc/hadoop/yarn-site.xml

###################################################################
# Format Hadoop Namenode
###################################################################
hdfs namenode -format

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################


