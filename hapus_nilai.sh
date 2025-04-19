#!/bin/bash
# Author : Mohammad Riza Al Fahri

FILE="nilai.txt"
echo "============== Hapus Nilai Mahasiswa =============="
read -p "Masukkan nama mahasiswa yang nilainya ingin dihapus: " nama_mhs
	
    grep -v "$nama_mhs:" $FILE 
    echo "Data nilai untuk $nama_mhs berhasil dihapus."
