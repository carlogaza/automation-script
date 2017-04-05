#!/bin/bash
###################################################################
# Hive Installation Script
# Hive version : 2.1.1
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract hive to /opt/
###################################################################
tar xzf $HIVE_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $HIVE_DIR


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

## HIVE env variables
export HIVE_HOME=$HIVE_DIR
export PATH=\$HIVE_HOME/bin:\$PATH
EOT

source .bashrc


###################################################################
# Configure Hive
###################################################################
sed -i '/# Default to use 256MB/i \ ' $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i # HADOOP directory' $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i export HADOOP_HOME='$HADOOP_DIR $HIVE_DIR/bin/hive-config.sh
sed -i '/# Default to use 256MB/i \ ' $HIVE_DIR/bin/hive-config.sh


###################################################################
# Configure hive-site.xml
###################################################################
cat <<EOT >> $HIVE_DIR/conf/hive-site.xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?><!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements. See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<configuration>
	<property>
		<name>javax.jdo.option.ConnectionURL</name>
		<value>jdbc:derby:;databaseName=$HIVE_METASTORE_DIR;create=true</value>
		<description>
			JDBC connect string for a JDBC metastore.
			To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
			For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
		</description>
	</property>
	<property>
		<name>hive.metastore.warehouse.dir</name>
		<value>/user/hive/warehouse</value>
		<description>location of default database for the warehouse</description>
	</property>
	<property>
		<name>hive.metastore.uris</name>
		<value/>
		<description>Thrift URI for the remote metastore. Used by metastore client to connect to remote metastore.</description>
	</property>
	<property>
		<name>javax.jdo.option.ConnectionDriverName</name>
		<value>org.apache.derby.jdbc.EmbeddedDriver</value>
		<description>Driver class name for a JDBC metastore</description>
	</property>
	<property>
		<name>javax.jdo.PersistenceManagerFactoryClass</name>
		<value>org.datanucleus.api.jdo.JDOPersistenceManagerFactory</value>
		<description>class implementing the jdo persistence</description>
	</property>
</configuration>
EOT


###################################################################
# Create HDFS directory for Hive
# note : Moved to init script, because cannot run on postinstall
###################################################################
: '
start-dfs.sh
hadoop fs -mkdir -p /user/hive/warehouse
hadoop fs -mkdir -p /tmp
hadoop fs -chmod g+w /user/hive/warehouse
hadoop fs -chmod g+w /tmp
'

###################################################################
# Initialization Apache Derby Database
# note : Moved to init script, because cannot run on postinstall
###################################################################
: '
schematool -initSchema -dbType derby
'


EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
