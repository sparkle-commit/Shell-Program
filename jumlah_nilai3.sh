#!/bin/bash
# Author : Mohammad Riza Al Fahri

total=0
i=1

while true
do
    read -p "Nilai ke-$i = " nilai
    if [ -z $nilai ]; then
        break
    fi

    case $nilai in
	    [0-9] ) 
		total=$((total + nilai))
                ((i++))
		;;
	    [0-9][0-9] ) 
		echo "Masukkan 1 digit!!";;
    	    * ) 
		echo "Masukkan angka!!";;
    esac
	

done
echo "Total nilai = $total"
