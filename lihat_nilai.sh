#!/bin/bash
# Nama Program : lihat nilai.sh
# Author : Mohammad Riza Al Fahri

IFS=":"
echo -e "Nama\tNilai"
echo "--------------"
while read nama nilai
do
	 echo -e "$nama\t$nilai"
done < nilai.txt
echo "--------------"
