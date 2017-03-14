#!/bin/bash
###################################################################
# HBase Installation Script
# HBase version : 1.2.4
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract hbase to /opt/
###################################################################
tar xzf $HBASE_INS -C $INSTALLATION_DIR
mkdir -p $HBASE_DATA
chown -R hduser:hadoop $HBASE_DIR
chown -R hduser:hadoop $HBASE_DATA


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

## HBASE env variables
export HBASE_HOME=$HBASE_DIR
export PATH=\$HBASE_HOME/bin:\$PATH
EOT

source .bashrc


###################################################################
# Configure HBase
###################################################################
# Backup configuration file
cp $HBASE_DIR/conf/hbase-site.xml $HBASE_DIR/conf/hbase-site.xml.bak
cp $HBASE_DIR/conf/hbase-env.sh $HBASE_DIR/conf/hbase-env.sh.bak

# Modify hbase-site.xml
sed -i '/<\/configuration>/i \\t<property>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.rootdir<\/name>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>$HBASE_DATA<\/value>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HBASE_DIR/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.quorum<\/name>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>localhost<\/value>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HBASE_DIR/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.cluster.distributed<\/name>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>true<\/value>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HBASE_DIR/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.property.dataDir<\/name>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>$HBASE_DATA/zookeeper<\/value>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HBASE_DIR/conf/hbase-site.xml

sed -i '/<\/configuration>/i \\t<property>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<name>hbase.zookeeper.property.clientPort<\/name>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t\t<value>2181<\/value>' $HBASE_DIR/conf/hbase-site.xml
sed -i '/<\/configuration>/i \\t<\/property>' $HBASE_DIR/conf/hbase-site.xml

# Modify hbase-env.sh
sed -i '/export JAVA_HOME=/a export JAVA_HOME=$JAVA_DIR' $HBASE_DIR/conf/hbase-env.sh
sed -i '/export HBASE_MANAGES_ZK=/a export HBASE_MANAGES_ZK=true' $HBASE_DIR/conf/hbase-env.sh

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################

