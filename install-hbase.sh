#!/bin/bash
###################################################################
# HBase Installation Script
# HBase version : 1.2.4
###################################################################


###################################################################
# Extract hbase to /opt/
###################################################################
cd /root/postinstall/apps
tar xzf hbase-1.2.4-bin.tar.gz -C /opt/
mkdir /opt/hbase-data
chown -R hduser:hadoop /opt/hbase-1.2.4/
chown -R hduser:hadoop /opt/hbase-data/


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## HBASE env variables
export HBASE_HOME=/opt/hbase-1.2.4/
export PATH=\$HBASE_HOME/bin:\$PATH
EOT

source .bashrc


###################################################################
# Configure HBase
###################################################################
# Backup configuration file
cp /opt/hbase-1.2.4/conf/hbase-site.xml /opt/hbase-1.2.4/conf/hbase-site.xml.bak
cp /opt/hbase-1.2.4/conf/hbase-env.sh /opt/hbase-1.2.4/conf/hbase-env.sh.bak

# Modify hbase-site.xml
sed -i '/<\/configuration>/i \\t<property>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.rootdir<\/name>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>/opt/hbase-data<\/value>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hbase-1.2.4/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.quorum<\/name>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>localhost<\/value>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hbase-1.2.4/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.cluster.distributed<\/name>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>true<\/value>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hbase-1.2.4/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.property.dataDir<\/name>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>/opt/hbase-data/zookeeper<\/value>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hbase-1.2.4/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.property.clientPort<\/name>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>2181<\/value>' /opt/hbase-1.2.4/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' /opt/hbase-1.2.4/conf/hbase-site.xml

# Modify hbase-env.sh
sed -i '/export JAVA_HOME=/a export JAVA_HOME=/usr/java/default' /opt/hbase-1.2.4/conf/hbase-env.sh
sed -i '/export HBASE_MANAGES_ZK=/a export HBASE_MANAGES_ZK=true' /opt/hbase-1.2.4/conf/hbase-env.sh

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################

