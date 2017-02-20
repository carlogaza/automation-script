#!/bin/bash

echo "---------------------------------------------------------------"
echo "| Install otomatis sshpass ke semua node                      |"
echo "| *note : gunakan root user                                   |"
echo "|                                                             |"
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

echo ""
echo "- - - - -"
echo "Installing sshpas in main host ..."
sudo rpm -Uvh sshpass-1.05-5.el7.x86_64.rpm
echo "Installation on main host success!"
echo "- - - - -"

for ((host=$AWAL;host<=$AKHIR;host++))
do
	echo "- - - - -"
	echo "Installing on host $IP.$host ..."
	sshpass -p $PASS scp -o "StrictHostKeyChecking no" sshpass-1.05-5.el7.x86_64.rpm $USER@$IP.$host:~
	sshpass -p $PASS ssh -o "StrictHostKeyChecking no" $USER@$IP.$host "rpm -Uvh sshpass-1.05-5.el7.x86_64.rpm"
	echo "Installation on host $IP.$host success!"
	echo "- - - - -"
done
