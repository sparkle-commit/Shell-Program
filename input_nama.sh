#!/bin/bash

echo -n "Nama anda: " 
read nama

if [ -n "$nama" ]; 
then
    echo "Nama anda adalah $nama"
else
    echo "Anda tidak memasukkan input"
fi

