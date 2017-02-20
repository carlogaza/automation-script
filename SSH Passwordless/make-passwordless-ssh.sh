#!/bin/bash

echo "---------------------------------------------------------------"
echo "| Contoh IP Address Range = 192.168.10.1 - 192.168.10.32      |"
echo "| Awalan IP Address = 192.168.10                              |"
echo "| IP Range awal = 1                                           |"
echo "| IP Range akhir = 32                                         |"
echo "---------------------------------------------------------------"
echo "Masukkan awalan IP Address atau Hostname Server:"
read IP
echo "Masukkan IP Range awal:"
read AWAL
echo "Masukkan IP Range akhir:"
read AKHIR
echo "Masukkan Username:"
read USER
echo "Masukkan Password:"
read PASS
echo "IP Address Range : $IP.$AWAL - $IP.$AKHIR"

for ((host=$AWAL;host<=$AKHIR;host++))
do
	echo ""
	echo "---"
	echo "Entering host $IP.$host ..."
	echo "Generating SSH Keygen ..."
	sshpass -p $PASS ssh -o "StrictHostKeyChecking no" $USER@$IP.$host "ssh-keygen -t rsa"

	for ((num=$AWAL;num<=$AKHIR;num++))
	do
		echo "Copying SSH key to server $IP.$num ..."
		sshpass -p $PASS ssh -o "StrictHostKeyChecking no" $USER@$IP.$host "sshpass -p $PASS ssh-copy-id -o 'StrictHostKeyChecking no' $USER@$IP.$num"
		echo "Copying to server $IP.$num success!"
	done

	echo "Leaving host $IP.$host ..."
	echo "---"
done
