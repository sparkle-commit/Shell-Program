#!/bin/bash
# Author : Mohammad Riza Al Fahri

echo "========================Input Nilai========================"
while true; 
do   
    read -p "Masukkan nama mahasiswa (atau tekan <Enter> untuk selesai): " nama_mhs
    if [ -z $nama_mhs ]; 
    then
        echo "Input selesai."
        break
    fi
    read -p "Masukan nilai mahasiswa (atau tekan <Enter> untuk selesai): " nilai

    echo "$nama_mhs:$nilai" >> nilai.txt
    echo "Data $nama_mhs dengan nilai $nilai berhasil disimpan."
done
