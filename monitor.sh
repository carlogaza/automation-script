#! /bin/bash

display_usage() {
	echo "Usage: $0 [running_time] [sequence_time]";
	echo "";
}

if [ $# -le 1 ]; then
	display_usage	
	exit 1;
fi

if [ $2 -gt $1 ]; then
	echo "Error: Sequence time cannot greater than running time";
	display_usage
	exit 1;
fi

printf "Time\tMemory\tCPU\n"

end=$((SECONDS+$1))

while [ $SECONDS -lt $end ];
do
	TIME=$(date | awk '{printf "%s\t", $(NF=4)}')
	MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t", $3*100/$2}')
	CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\n", $(NF-2)}')
	echo "$TIME$MEMORY$CPU"
	sleep $2
done
