#!/bin/bash
# Author : Mohammad Riza Al Fahri
  
echo "Opsi yang tersedia:"
echo ===================
select pilih in "Input Nilai" "Lihat Nilai" "Hapus Nilai" "Selesai";
do
	case "$REPLY" in
	   1 ) tambah_nilai.sh ;;
	   2 ) lihat_nilai.sh ;;
	   3 ) hapus_nilai.sh ;;
	   4 ) read -p "Thank you, tekan [Enter]"; break ;;
	esac
done
