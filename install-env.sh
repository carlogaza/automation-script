#!/bin/bash
###################################################################
# Environment Variable Installation Script
# Desc : All path variable of installer and directory installation
###################################################################


###################################################################
# This is installer path
###################################################################
INSTALLER_DIR=/root/postinstall/apps
MPICH_INS=$INSTALLER_DIR/mpich-3.2.tar.gz
MAVEN_INS=$INSTALLER_DIR/apache-maven-3.3.9-bin.tar.gz
HADOOP_INS=$INSTALLER_DIR/hadoop-2.7.3.tar.gz
ZOOKEEPER_INS=$INSTALLER_DIR/zookeeper-3.4.9.tar.gz
PIG_INS=$INSTALLER_DIR/pig-0.16.0.tar.gz
HIVE_INS=$INSTALLER_DIR/apache-hive-2.1.1-bin.tar.gz
HBASE_INS=$INSTALLER_DIR/hbase-1.2.4-bin.tar.gz
FLUME_INS=$INSTALLER_DIR/apache-flume-1.7.0-bin.tar.gz
SCALA_INS=$INSTALLER_DIR/scala-2.12.1.tgz
SPARK_INS=$INSTALLER_DIR/spark-2.1.0-bin-hadoop2.7.tgz
ZEPPELIN_INS=$INSTALLER_DIR/zeppelin-0.7.0-bin-all.tgz


###################################################################
# This is installation path
###################################################################
INSTALLATION_DIR=/opt
MPICH_INSTALLATION_DIR=/usr/local
MPICH_DIR=$MPICH_INSTALLATION_DIR/mpich-3.2/
MAVEN_DIR=$INSTALLATION_DIR/apache-maven-3.3.9/
JAVA_DIR=/usr/java/default
HADOOP_DIR=$INSTALLATION_DIR/hadoop-2.7.3/
ZOOKEEPER_DIR=$INSTALLATION_DIR/zookeeper-3.4.9/
PIG_DIR=$INSTALLATION_DIR/pig-0.16.0/
HIVE_DIR=$INSTALLATION_DIR/apache-hive-2.1.1-bin/
HBASE_DIR=$INSTALLATION_DIR/hbase-1.2.4/
FLUME_DIR=$INSTALLATION_DIR/apache-flume-1.7.0-bin/
SCALA_DIR=$INSTALLATION_DIR/scala-2.12.1/
SPARK_DIR=$INSTALLATION_DIR/spark-2.1.0-bin-hadoop2.7/
ZEPPELIN_DIR=$INSTALLATION_DIR/zeppelin-0.7.0-bin-all/


###################################################################
# This is configuration data path
###################################################################
NAMENODE_DIR=/opt/volume/namenode
DATANODE_DIR=/opt/volume/datanode
HBASE_DATA=/opt/volume/hbase-data
ZOOKEEPER_DATA=/opt/volume/zookeper-data

