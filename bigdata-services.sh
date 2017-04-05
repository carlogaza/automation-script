#! /bin/bash

display_usage() {
	echo "Usage: $0 [OPTION] [TARGET]...";
	echo "";
	echo "OPTION command is to start stop or check status."
	echo "	--help		show help."
	echo "	--start		to start service."
	echo "	--stop		to stop service."
	echo "	--status	to check running service."
	echo "";
	echo "TARGET command is what service you want to start."
	echo "	all		all installed big data service."
	echo "	hdfs		HDFS service."
	echo "	yarn		YARN service."
	echo "	spark-master	Spark Master service."
	echo "	spark-slave	Spark Slave service."
	echo "	hbase		HBASE service."
	echo "";
}

start_hdfs() {
	$HADOOP_HOME/sbin/start-dfs.sh
	echo "HDFS		[Running]"
}

start_yarn() {
	$HADOOP_HOME/sbin/start-yarn.sh
	echo "YARN		[Running]"
}

start_spark_master() {
	$HADOOP_HOME/sbin/start-yarn.sh
	echo "YARN		[Running]"
}

if [ $# -lt 1 ]; then
	display_usage	
	exit 1;
fi

while [ "$1" != "" ];
do
	case $1 in
		--help )	display_usage
				exit
				;;
		--start )	echo "start"
				exit
				;;
		--stop )	echo "stop"
				exit
				;;
		--status )	echo "status"
				exit
				;;
	esac
	shift
done
