pembuatan Variable dalam Lingkungan Linux sangat membantu dalam mengurus sebuah perintah dengan menggunakan:

`PATH=$PATH:$HOME/skripku` 
`MOTO=/var/lib/nginx` : Oke, _sorry_ banget kalau penjelasan gue sebelumnya malah bikin lo tambah pusing. Santai bro, mari kita bikin super gampang pakai contoh kerjaan nyata.

Guna utama variabel itu sebenarnya sesederhana ini: **biar lo nggak capek ngetik teks yang sama berulang-ulang, dan biar script (program otomatisasi) lo gampang diubah-ubah**.

Bayangkan skenario ini: Bos lo nyuruh lo untuk ngerjain sesuatu di dalam sebuah folder yang lokasinya super panjang, misalnya di `/var/log/nginx/error/website-utama/tahun-2026/bulan-april/`.

Tanpa variabel, lo harus ngetik ini di terminal atau di dalam _script_:

1. `cp laporan.txt /var/log/nginx/error/website-utama/tahun-2026/bulan-april/`
2. `mkdir /var/log/nginx/error/website-utama/tahun-2026/bulan-april/backup/`
3. `ls -l /var/log/nginx/error/website-utama/tahun-2026/bulan-april/`

Pegal dan rawan _typo_ kan ngetik _path_ sepanjang itu berkali-kali? Nah, di sinilah variabel (si _sticky note_ tadi) menyelamatkan hidup lo.

Lo cukup simpan teks panjang itu ke dalam sebuah variabel di awal _script_, misalnya lo kasih nama **LOKASI**: `LOKASI="/var/log/nginx/error/website-utama/tahun-2026/bulan-april/"`

Setelah lo bikin variabel itu, ke depannya lo cuma perlu memanggil namanya dengan tambahan tanda dolar (`$`) di depannya. Perintah lo yang pegal tadi langsung berubah jadi super pendek:

1. `cp laporan.txt $LOKASI`
2. `mkdir $LOKASI/backup/`
3. `ls -l $LOKASI`

**Satu lagi keuntungan terbesarnya bro:** Bayangkan bulan depan bos lo minta hal yang sama persis, tapi untuk **bulan-mei**. Kalau lo nggak pakai variabel, lo harus mencari kata "bulan-april" dan menggantinya jadi "bulan-mei" di puluhan atau ratusan baris perintah secara manual.

Tapi karena lo pakai variabel, lo **cuma perlu mengubah satu baris paling atas aja** menjadi `LOKASI="/var/log/nginx/error/website-utama/tahun-2026/bulan-mei/"`. Setelah itu, semua perintah di bawahnya akan otomatis menggunakan lokasi yang baru tanpa perlu lo edit lagi.

Jadi, kesimpulannya: saat lo bikin `skrip2="Folder Skrip 2..."`, lo sebenarnya sedang memberi tahu si Linux, _"Eh Linux, mulai sekarang kalau gue panggil nama **$skrip2**, maksud gue adalah teks panjang itu ya. Ingat-ingat di otak lo!"_

Gimana bro, sudah lebih kebayang kan kenapa fitur variabel ini wajib banget dipakai kalau lo mau bikin program atau _script_ otomatisasi ke depannya?

--- 
Wajar banget kalau lo bingung, Bro! Ini adalah salah satu konsep yang paling sering bikin ketukar saat baru belajar Linux. Biar gue lurusin: **Membuat variabel itu TIDAK SAMA dengan membuat folder atau file.**

Tebakan lo bahwa `skrip2="Folder Skrip 2..."` akan membuat folder baru di `/home/user/` adalah **salah**.

Mari kita bedah perbedaan keduanya yang sangat jauh ini:

**1. Perintah `sudo mkdir -p $HOME/skrip2` (Membuat Direktori/Folder)** Perintah ini bekerja langsung pada _hard disk_ lo. Fungsi `mkdir` adalah benar-benar menciptakan sebuah wadah atau folder fisik bernama `skrip2` di dalam direktori `/home/user/`.

- Setelah perintah ini dijalankan, foldernya benar-benar ada. Lo bisa melihatnya dengan perintah `ls`, masuk ke dalamnya dengan `cd`, dan menyimpan skrip-skrip lo di sana.

**2. Perintah `skrip2="Folder Skrip 2..."` (Membuat Variabel)** Perintah ini **tidak membuat folder ataupun file apa pun di hard disk lo**. Perintah ini hanya membuat sebuah variabel lokal, yakni sebuah "ruang penyimpanan sementara" di dalam **memori (RAM)** terminal (_shell_) yang sedang lo buka.

- Di sini, `skrip2` hanyalah sebuah label atau nama, dan `"Folder Skrip 2 setelah totur skripku"` hanyalah sekumpulan teks biasa (_string_) yang lo simpan ke dalam label tersebut.
- Ingat, aturan mutlak di Linux adalah tidak boleh ada spasi antara nama variabel, tanda sama dengan (`=`), dan nilainya.

**Analogi Gampangnya Gini Bro:**

- **`mkdir`** itu ibarat lo memanggil tukang kayu untuk **membangun sebuah laci baru** (folder) di meja kerja lo (_hard disk_).
- **Variabel (`skrip2="..."`)** itu ibarat lo mengambil kertas _sticky notes_, menuliskan kalimat panjang di situ, lalu menempelkannya di jidat lo (_memori shell_). Kertas itu cuma tulisan sementara, bukan sebuah laci yang bisa lo isi barang!

**Cara Membuktikannya di Terminal lo sekarang:** Coba buka terminal lo dan jalankan eksperimen ini:

1. Ketik: `skrip2="Folder Skrip 2 setelah totur skripku"`.
2. Lalu ketik: `ls $HOME`. Lo **TIDAK AKAN** menemukan folder bernama `skrip2` di sana karena itu memang bukan folder.
3. Sekarang ketik: `echo $skrip2`. Layar terminal akan menampilkan teks panjang yang lo simpan tadi.

**Lalu, kenapa Variabel ini sangat penting?** Nantinya saat lo menulis _shell script_ (program otomatisasi DevOps), lo akan butuh variabel untuk menyimpan data sementara agar lo nggak capek mengetik ulang. Misalnya, daripada setiap saat mengetik direktori yang sangat panjang seperti `/home/user/Documents/Data/Skrip/Produksi/`, lo cukup menyimpannya di memori dengan `LOKASI="/home/user/Documents/Data/Skrip/Produksi/"` dan kelak lo tinggal memanggilnya dengan mengetikkan `$LOKASI`.

--- 
**Variabel lingkungan (environment variables)** sangat penting karena ini adalah cara sistem operasi Linux dan _shell_ menyimpan informasi dinamis untuk mengetahui pengaturan pengguna, lokasi program, dan bagaimana sistem harus berperilaku. Ibaratnya, ini adalah "buku catatan" atau memori otak dari _shell_ Linux tempat lo bekerja.

Secara spesifik, **`$PATH` adalah variabel lingkungan yang paling vital karena ia berisi daftar direktori (folder) yang akan selalu digeledah oleh sistem setiap kali lo mengetikkan sebuah perintah**. Ketika lo mengetik nama program (misalnya `ls` atau `tes_variable.sh`), Linux tidak mencari ke seluruh isi _hard disk_ karena itu akan sangat lambat. Linux hanya akan mencari ke dalam folder-folder yang terdaftar di dalam variabel `$PATH`. Jika program tidak ditemukan di daftar folder tersebut, terminal akan menampilkan _error_ "command not found".

Tebakan lo 100% benar! **Jika lo memasukkan perintah `PATH=$PATH:$HOME/skripku`, lo menambahkan folder `skripku` ke dalam daftar pencarian sistem**. Jadi, meskipun lo sedang berada di dalam folder `/opt` atau `/etc`, lo cukup mengetikkan `tes_variable.sh` dan sistem akan langsung menemukannya serta mengeksekusinya.

---

### **Perbedaan Global vs. Local Variables**

Di Linux, setiap kali lo membuka terminal atau menjalankan _script_, lo sedang menjalankan sebuah proses _shell_ (biasanya _bash_). Jika dari dalam terminal itu lo mengetikkan `bash` lagi, lo membuat proses _shell_ baru di dalam _shell_ yang lama, yang disebut sebagai **subshell (child process)**.

- **Variabel Lokal:** Hanya dikenali oleh _shell_ tempat lo membuatnya. Variabel ini **tidak akan diwariskan** ke _subshell_ atau program baru yang lo jalankan.
- **Variabel Global:** Dikenali oleh _shell_ saat ini **dan akan selalu diwariskan** ke setiap _subshell_ (anak proses) atau _script_ yang lo jalankan dari terminal tersebut.

### **Bedah Kasus Perintah `MOTO="DevOps Keren"`**

Supaya nggak bingung, ini adalah jalan cerita dari perintah yang lo ketikkan baris demi baris:

1. **`MOTO="DevOps Keren"`** Lo baru saja membuat sebuah **variabel lokal** bernama `MOTO` di terminal utama (induk).
2. **`bash`** Lo memerintahkan Linux untuk membuka **subshell baru (anak)** di atas terminal yang sedang berjalan.
3. **`echo $MOTO`** Hasilnya **kosong** (blank). Kenapa? Karena saat ini lo sedang berada di dalam _shell anak_, dan variabel `MOTO` tadi berstatus lokal di _shell induk_. Shell anak tidak mewarisi variabel lokal dari orang tuanya.
4. **`exit`** Lo mematikan _shell anak_ tersebut dan **kembali ke terminal utama (induk)** tempat variabel `MOTO` tadi dibuat.
5. **`export MOTO`** Ini adalah kunci utamanya. Perintah `export` berfungsi **mengubah variabel lokal menjadi variabel global**. Sekarang `MOTO` berstatus global.
6. **`bash`** Lo kembali membuka **subshell baru (anak)**.
7. **`echo $MOTO`** Sekarang hasilnya muncul **DevOps Keren**. Karena `MOTO` sudah di-_export_ menjadi global oleh orang tuanya, _shell anak_ yang baru ini berhasil mewarisi dan bisa membaca nilainya.

**Satu hal penting:** Perubahan variabel (seperti penambahan `$PATH` atau pembuatan `MOTO`) yang lo lakukan dengan cara di atas **hanya bersifat sementara** dan akan hilang saat lo menutup terminal. Agar permanen, perintah `export` tersebut harus lo simpan ke dalam _file_ konfigurasi tersembunyi bernama `.bashrc` di _home directory_ lo.

--- 







# REVIEW PELAJARAN ENVI VARIABLE
