#!/bin/bash
#Nama program : projek.sh
#Author : Mohammad Riza Al Fahri


main_menu() {
    clear
    echo "================================"
    echo "  SELAMAT DATANG DI MENU UTAMA  "
    echo "================================"
    echo "1. Monitoring Sistem"
    echo "2. Pengelolaan User"
    echo "3. Penjadwalan Tugas"
    echo "4. Keluar"
    echo "--------------------------------"
    read -p "Pilih opsi [1-4]: " choice
    clear
    case $choice in
        1) monitor_system ;;
        2) manage_users ;;
	3) task_manager ;;
        4) exit_program ;;
        *) echo "Waduuuhh..Opsi tidak tersedia!!" 
	sleep 2
	main_menu ;;
    
    esac
}


monitor_system() {
    clear
    echo "================================="
    echo "         Monitoring Sistem       "
    echo "================================="
    echo "CPU Usage:"
    grep 'cpu ' /proc/stat 
    echo ""
    echo "RAM Usage:"
    free -h 
    echo ""
    echo "Disk Usage:"
    df -h 
    echo "---------------------------------"
    read -p "Tekan [Enter] untuk kembali ke menu utama..."
    main_menu
}


manage_users() {

    echo "================================="
    echo "        Pengelolaan User         "
    echo "================================="
    echo "1. Lihat User"
    echo "2. Tambah User"
    echo "3. Hapus User"
    echo "4. Ubah Password User"
    echo "5. Kembali ke Menu Utama"
    echo "---------------------------------"
    read -p "Pilih opsi [1-5]: " user_choice
    clear
    case $user_choice in
	1) see_user;;
        2) add_user ;;
        3) delete_user ;;
        4) change_password ;;
        5) main_menu ;;
        *) echo "Opsi tidak tersedia!"; sleep 2; manage_users ;;
    esac
}

see_user() {

    dialog --title "Daftar User di Sistem" \
           --msgbox "Menampilkan daftar user di sistem. Tekan OK untuk melanjutkan." 10 50
    dialog --title "Butuh Kepastian :D" \
           --yesno "Yakin mau tau banget nich??" 10 40

    local users
    users=$(cut -d: -f1 /etc/passwd)
    dialog --title "Daftar User di Sistem" \
           --msgbox "$users" 20 70

    dialog --title "Kembali ke Menu" \
           --msgbox "Tekan OK untuk kembali ke menu!!" 10 50
    clear
    manage_users
}


add_user() {
    
    username=$(dialog --title "Tambah User Baru" --inputbox "Masukkan nama user baru dulu dong..:" 10 50 3>&1 1>&2 2>&3)

   
    if [ -z "$username" ]; then
        dialog --title "Batal" --msgbox "Nama user tidak boleh kosong!" 10 50
        manage_users  
        return
    fi

   
    sudo useradd "$username"
    if [ $? -eq 0 ]; then
        dialog --title "Sukses" --msgbox "Horee...User $username berhasil ditambahkan." 10 50
    else
        dialog --title "Error" --msgbox "Gagal menambahkan user $username." 10 50
    fi
    clear
    manage_users  
}


delete_user() {
    
    username=$(dialog --title "Hapus User" --inputbox "Masukkan nama user yang akan dihapus:" 10 50 3>&1 1>&2 2>&3)

    if [ -z "$username" ]; then
        dialog --title "Batal" --msgbox "Operasi dibatalkan atau nama user kosong. Kembali ke menu utama." 10 50
        return
    fi

    sudo userdel "$username"
    if [ $? -eq 0 ]; then
        dialog --title "Sukses" --msgbox "Yeay..User $username berhasil dihapus!" 10 50
    else
        dialog --title "Error" --msgbox "Gagal menghapus user $username! Pastikan user ada di sistem." 10 50
    fi

    clear
    manage_users
}



change_password() {
  username=$(dialog --inputbox "Masukkan nama pengguna:" 10 40 3>&1 1>&2 2>&3)

  if [[ -z "$username" ]]; then
    echo "Nama pengguna tidak boleh kosong."
    return 1
  fi

  dialog --yesno "Apakah Anda yakin ingin mengubah password untuk $username?" 10 40
  if [ $? -eq 0 ]; then
    sudo passwd $username
    if [ $? -eq 0 ]; then
      dialog --msgbox "Yeay..Password untuk user $username berhasil diubah." 10 40
    else
      dialog --msgbox "Gagal mengubah password untuk user $username." 10 40
    fi
  fi
  clear
  manage_users
}

task_manager() {
    clear    
    echo "================================"
    echo "     Menu Penjadwalan Tugas     "
    echo "================================"
    echo "1. List tugas cron"
    echo "2. Tambah tugas cron"
    echo "3. Hapus tugas cron"
    echo "4. Simulasi tugas cron"
    echo "5. Kembali ke menu utama"
    echo "--------------------------------"

    read -p "Pilih [1-5]: " choice

    case $choice in
        1) list_cron_jobs ;;
        2) add_cron_job ;;
        3) remove_cron_job ;;
        4) simulate_cron_job ;;
        5) main_menu ;;
        *) echo "Pilihan tidak tersedia!!"
	   task_manager;;
    esac
}

list_cron_jobs() {
    clear
    echo "Tugas cron saat ini :"
    crontab -l 2>/dev/null || echo "Yaah..tidak ada tugas cron saat ini."
    echo ""
    echo ""
    read -p "Tekan [Enter] untuk kembali..."
    task_manager

    
}

add_cron_job() {
    clear
    read -p "Masukan perintah untuk jadwal: " command
    read -p "Masukan jadwal cron (e.g., '* * * * *'): " schedule
    (crontab -l 2>/dev/null; echo "$schedule $command") | crontab -
    echo "Siip!!, Tugas cron baru berhasil ditambahkan."
    echo ""
    echo ""
    read -p "Tekan [Enter] untuk kembali..."
    task_manager
}

remove_cron_job() {
    clear
    jobs=$(crontab -l 2>/dev/null)

    if [ -z "$jobs" ]; then
        echo "Waduuh... Tidak ada crontab untuk pengguna saat ini nih!!."
	sleep 2
	task_manager
    fi

    echo "Tugas cron saat ini:"
    echo "$jobs" | nl

    read -p "Masukkan nomor tugas untuk dihapus dooongs!!: " job_number

    current_line=1
    {
        while IFS= read -r line; do
            if [ "$current_line" -ne "$job_number" ]; then
                echo "$line" 
            fi
            ((current_line++))
        done <<< "$jobs"
    } | crontab -

    echo "Yoooiii.. Tugas cron berhasil dihapus!!"
    echo ""
    echo ""
    read -p "Tekan [Enter] untuk kembali..."
    task_manager
}


simulate_cron_job() {
    clear
    read -p "Masukan perintah untuk simulasi: " command
    echo "Perintah berjalan: $command"
    ($command)
    echo ""
    echo ""
    read -p "Tekan [Enter] untuk kembali..."
    task_manager
}

exit_program() {
  dialog --msgbox "See You Next Time :)" 10 30
  clear
  exit 0    
}

# Jalankan menu utama
main_menu
