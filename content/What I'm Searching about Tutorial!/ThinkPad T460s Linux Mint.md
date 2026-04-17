Untuk ThinkPad T460s yang menjalankan Linux Mint, Anda sebenarnya memiliki perangkat yang sangat "Linux-friendly." Namun, alasan kenapa _wake up_ (resume) masih terasa kalah cepat dari Mac adalah karena pengaturan default Linux Mint sering kali menggunakan mode "s2idle" (standby ringan) yang kurang efisien atau "deep sleep" yang inisialisasi driver-nya lambat. [1, 2]

Berikut adalah langkah konkret untuk mempercepat _wake up_ di ThinkPad T460s Anda:

## 1. Ubah Kernel Parameter (Solusi Paling Ampuh)

Pada seri T460, ada masalah teknis pada manajemen memori (IOMMU) yang sering membuat proses _resume_ tertunda atau "nyangkut" beberapa detik. [3]

- Buka terminal, ketik: `sudo nano /etc/default/grub`
- Cari baris yang dimulai dengan `GRUB_CMDLINE_LINUX_DEFAULT`.
- Tambahkan `intel_iommu=off` di dalam tanda kutip. Contoh:  
    `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_iommu=off"`
- Simpan (Ctrl+O, Enter) dan keluar (Ctrl+X).
- Update grub: `sudo update-grub` lalu restart laptop Anda. [3]

## 2. Optimasi Driver Intel GPU

Kadang driver kartu grafis bawaan mencoba memuat fitur penghemat daya yang justru memperlambat proses bangun layar. [4, 5]

- Pastikan Anda tidak memiliki parameter `enable_guc=2` di konfigurasi modprobe Anda, karena ini dilaporkan menyebabkan masalah _wake up_ pada T460s dengan Linux Mint 22. [4]

## 3. Gunakan TLP untuk Manajemen Daya [6]

ThinkPad dan Linux adalah pasangan emas jika menggunakan TLP. Alat ini mengoptimalkan firmware ThinkPad agar lebih responsif saat perpindahan daya. [6, 7]

- Instal dengan: `sudo apt install tlp tlp-rdw`
- Mulai TLP: `sudo tlp start`
- TLP akan membantu mengatur _power state_ perangkat keras agar tidak "tidur terlalu nyenyak" sehingga sulit dibangunkan. [8]

## 4. Cek Pengaturan BIOS

Pastikan pengaturan "Sleep State" di BIOS Anda.

- Masuk BIOS (tekan F1 saat booting).
- Cari menu Config > Power.
- Jika ada opsi Sleep State, pilih Linux (jika tersedia) atau pastikan tidak dalam mode "Windows 10" yang menggunakan Modern Standby, karena Linux lebih stabil dengan mode S3 tradisional. [1, 9]

---

## Mengapa Mac Masih Terasa Lebih Cepat?

Meskipun sudah dioptimalkan, T460s adalah laptop keluaran sekitar tahun 2016. Mac (terutama seri M1/M2) menggunakan Unified Memory Architecture, di mana RAM dan CPU berada dalam satu paket, memungkinkan data _resume_ berpindah hampir instan tanpa hambatan jalur bus lama seperti pada arsitektur Intel i5 Gen-6 di T460s Anda. [10, 11]

Pro-Tip: Jika _wake up_ masih terasa lambat, coba kurangi nilai Swappiness ke 10 agar sistem tidak terlalu sering memindahkan data dari RAM ke SSD/HDD saat akan masuk mode tidur. [12]

Apakah Anda mengalami masalah spesifik seperti layar tetap hitam saat dibuka, atau hanya jeda waktu saja? Saya bisa berikan perintah terminal untuk mengecek log error jika dibutuhkan.

  

[1] [https://www.reddit.com](https://www.reddit.com/r/thinkpad/comments/1505if1/linux_sleep_mode_on_newer_thinkpad_missing/)

[2] [https://www.reddit.com](https://www.reddit.com/r/linux4noobs/comments/1gaexkn/thinkpad_t480s_slow_as_hell_to_wake_up_from/#:~:text=The%20thing%20is%2C%20when%20i%20opened%20the,a%20minute%20every%20time%20I%27m%20doing%20it.)

[3] [https://www.reddit.com](https://www.reddit.com/r/linuxmint/comments/1hzjw4t/how_to_wake_up_linux_mint_from_suspend_without/)

[4] [https://forums.linuxmint.com](https://forums.linuxmint.com/viewtopic.php?t=425710)

[5] [https://www.facebook.com](https://www.facebook.com/groups/linuxmintdesktop/posts/1843801716574728/)

[6] [https://forums.linuxmint.com](https://forums.linuxmint.com/viewtopic.php?t=438136)

[7] [https://linuxblog.io](https://linuxblog.io/boost-battery-life-on-linux-laptop-tlp/#:~:text=However%2C%20for%20those%20who%20frequently%20find%20themselves,life%20into%20an%20all%2Dday%20endurance%20battery%20life.)

[8] [https://www.reddit.com](https://www.reddit.com/r/linuxmint/comments/b7zzat/is_tlp_a_must_for_laptops/)

[9] [https://www.reddit.com](https://www.reddit.com/r/Lenovo/comments/zq3tc5/how_to_disable_modern_sleep_and_enable_s3_sleep/)

[10] [https://shopee.co.id](https://shopee.co.id/LAPTOP-Lenovo-Thinkpad-T460S-CORE-i5-GEN-6TH-Touchscreen-RAM-12GB-256-SSD-WIN-10pro-i.1050478176.24900117474#:~:text=LAPTOP%20Lenovo%20Thinkpad%20T460S%20CORE%20i5%20GEN%206TH%20Touchscreen%20RAM%2012GB/256%20SSD%20WIN%2010pro.)

[11] [https://www.blibli.com](https://www.blibli.com/jual/lenovo-thinkpad-t460s#:~:text=Table_title:%20Daftar%20Harga%20Lenovo%20Thinkpad%20T460s%20Terbaru,LAYAR%2014%20INCHI%20%7C%20Harga:%20Rp3.700.000%20%7C)

[12] [https://www.reddit.com](https://www.reddit.com/r/linuxmint/comments/1m84bgx/laggy_wake_from_sleepsuspend/)