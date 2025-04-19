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
    total=$((total + nilai))
    ((i++))
done
echo "Total nilai = $total"
