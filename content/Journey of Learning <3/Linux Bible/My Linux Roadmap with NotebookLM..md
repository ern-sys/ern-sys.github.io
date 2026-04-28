Halo! Semangat yang Anda miliki untuk keluar dari lingkungan _toxic_ dan meningkatkan karir dari IT Support menjadi seorang DevOps atau Site Reliability Engineer (SRE) adalah langkah awal yang sangat luar biasa. Mengingat Anda sudah berada di level _intermediate_ dan familiar dengan perintah dasar Linux serta telah mulai bereksperimen dengan _scripting_ dan _permissions_ (seperti yang kita bahas sebelumnya), Anda tidak perlu lagi mengulang dari nol.

Sumber buku yang Anda miliki (_The Linux Command Line_, _Linux Command Line and Shell Scripting Bible_, _Linux Basics for Hackers_, dll.) adalah kombinasi emas untuk jalur karir yang Anda tuju.

Agar Anda bisa belajar secara sistematis tanpa merasa _overwhelmed_, berikut adalah rancangan kurikulum yang dirancang khusus untuk rutinitas harian Anda (45 menit/sesi).

---

### 1. PETA MODUL (Jalur DevOps & SRE)

**Modul 1: Penguasaan Ekosistem & Manajemen Sumber Daya (Intermediate Foundation)** Memahami lebih dalam bagaimana Linux mengelola aplikasi yang berjalan, mengatur lingkungan sistem (_environment_), dan memanajemen media penyimpanan. Modul ini krusial untuk kegiatan pemantauan (_monitoring_) di DevOps.

**Modul 2: Manipulasi Teks & Analisis Data Log (Data Mastery)** Menguasai fitur kelas berat Linux (Regular Expression, `sed`, `gawk`) untuk menyaring, mengubah, dan memformat teks biasa. Ini adalah _skill_ utama untuk menganalisis log _server_ saat terjadi _error_ atau _bug_.

**Modul 3: Fondasi Automasi dengan Shell Scripting (Core Automation)** Membangun logika dasar pemrograman Bash mulai dari variabel, pengkondisian (`if/case`), hingga perulangan (`loops`). Fokus utamanya adalah menghilangkan pekerjaan manual yang berulang.

**Modul 4: Automasi Lanjut & Manajemen Jaringan (Advanced SysAdmin)** Mengimplementasikan _scripting_ ke dalam tugas nyata seperti menjadwalkan pekerjaan (_cron_), mengekstrak data dari web, dan berinteraksi dengan layanan _database_ jarak jauh.

---

### 2. BREAKDOWN SESI HARIAN & 4. PRIORITAS

Setiap sesi dirancang untuk **45 menit praktik**. Anda bisa menggunakan _distrobox_ yang sudah Anda setup untuk menjalankan sesi-sesi ini.

| Sesi   | Modul & Topik                                  | Prioritas | Referensi Buku                                                                     | Target Konkret (Setelah sesi ini, saya bisa...)                                                                                                                                             | Tanggal       | Checklist |
| :----- | :--------------------------------------------- | :-------- | :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | --------- |
| **1**  | **Mod 1:** Manajemen Proses & _Monitoring_     | **WAJIB** | _The Linux Command Line (TLCL)_ - Bab 10; _Linux Basics for Hackers (LBH)_ - Bab 6 | **Setelah sesi ini, saya bisa:** Melacak proses yang memonopoli CPU/RAM menggunakan `top`/`ps`, dan menghentikan proses yang bermasalah di _background_ menggunakan `kill`,.                | 28 April 2026 | - [ ]     |
| **2**  | **Mod 1:** Environment Variables               | **WAJIB** | _TLCL_ - Bab 11; _LBH_ - Bab 7                                                     | **Setelah sesi ini, saya bisa:** Melihat, membuat, dan memodifikasi variabel lingkungan seperti `$PATH` dan `$HOME` untuk mengonfigurasi bagaimana sistem mengeksekusi program,.            |               |           |
| **3**  | **Mod 1:** Manajemen Paket (_Package_)         | **WAJIB** | _TLCL_ - Bab 14; _LCLSSB_ - Bab 9                                                  | **Setelah sesi ini, saya bisa:** Menginstal, memperbarui, dan menghapus paket _software_ menggunakan sistem PMS (seperti `apt`/`dpkg` atau `yum`) serta mengelola _dependencies_,.          |               |           |
| **4**  | **Mod 1:** Manajemen _Storage_ & LVM           | OPTIONAL  | _LCLSSB_ - Bab 8; _TLCL_ - Bab 15                                                  | **Setelah sesi ini, saya bisa:** Memahami konsep _Logical Volume Manager_ (LVM) untuk membuat dan memperbesar partisi disk secara dinamis menggunakan CLI,.                                 |               |           |
| **5**  | **Mod 2:** Regular Expression (Regex) Dasar    | **WAJIB** | _TLCL_ - Bab 19; _LCLSSB_ - Bab 20                                                 | **Setelah sesi ini, saya bisa:** Menggunakan simbol Regex (seperti `^`, `$`, `*`, `[]`) yang digabungkan dengan `grep` untuk mencari pola teks atau _error_ spesifik di dalam file _log_,.  |               |           |
| **6**  | **Mod 2:** Stream Editor (`sed`)               | **WAJIB** | _TLCL_ - Bab 20; _LCLSSB_ - Bab 19 & 21,                                           | **Setelah sesi ini, saya bisa:** Mencari dan mengganti teks secara otomatis di dalam banyak file secara serentak tanpa harus membuka teks editor interaktif,.                               |               |           |
| **7**  | **Mod 2:** Ekstraksi Data dengan `gawk`        | **WAJIB** | _LCLSSB_ - Bab 19 & 22,                                                            | **Setelah sesi ini, saya bisa:** Memfilter file berformat kolom (seperti CSV atau tabel log server) menjadi laporan rapi yang mudah dibaca menggunakan perintah `gawk`,.                    |               |           |
| **8**  | **Mod 2:** Investigasi Log Sistem              | OPTIONAL  | _LBH_ - Bab 11; _Linux 3in1_ - Bab 6                                               | **Setelah sesi ini, saya bisa:** Mengidentifikasi log aktivitas, keamanan, dan _error_ pada direktori `/var/log` menggunakan otomatisasi rotasi log (`logrotate`),,.                        |               |           |
| **9**  | **Mod 3:** _Variables_ & Substitusi di Script  | **WAJIB** | _TLCL_ - Bab 24 & 25,; _LCLSSB_ - Bab 11                                           | **Setelah sesi ini, saya bisa:** Membuat _executable shell script_ `.sh` sederhana yang menangkap _output_ dari perintah Linux (_command substitution_) dan menyimpannya di dalam variabel. |               |           |
| **10** | **Mod 3:** _Flow Control_ (`if-then` & `case`) | **WAJIB** | _TLCL_ - Bab 27 & 31,; _LCLSSB_ - Bab 12                                           | **Setelah sesi ini, saya bisa:** Menggunakan logika `if-then` untuk menguji kondisi (misalnya: apakah sebuah file _backup_ ada?) sebelum sistem mengeksekusi perintah lanjutan,.            |               |           |
| **11** | **Mod 3:** _Looping_ (`for` & `while`)         | **WAJIB** | _TLCL_ - Bab 29 & 33,; _LCLSSB_ - Bab 13                                           | **Setelah sesi ini, saya bisa:** Menggunakan _loop_ `for` dan `while` untuk mengeksekusi serangkaian perintah berulang pada ratusan file sekaligus tanpa intervensi manual,.                |               |           |
| **12** | **Mod 3:** Fungsi (_Functions_)                | OPTIONAL  | _TLCL_ - Bab 26; _LCLSSB_ - Bab 17                                                 | **Setelah sesi ini, saya bisa:** Memecah _script_ yang sangat panjang menjadi blok-blok fungsi yang bisa dipanggil kembali (_reusable code_) agar _script_ lebih rapi,.                     |               |           |
| **13** | **Mod 4:** Penjadwalan (_Cron_ & _Anacron_)    | **WAJIB** | _LBH_ - Bab 16; _LCLSSB_ - Bab 16                                                  | **Setelah sesi ini, saya bisa:** Mendaftarkan _shell script_ ke dalam utilitas `crontab` agar tereksekusi secara otomatis di latar belakang setiap hari/minggu,.                            |               |           |
| **14** | **Mod 4:** Interaksi Jaringan & SSH            | **WAJIB** | _TLCL_ - Bab 16; _LBH_ - Bab 12                                                    | **Setelah sesi ini, saya bisa:** Melakukan transfer data dengan aman, mengambil konten halaman web dari terminal menggunakan `curl`/`wget`, dan terhubung (_login_) via OpenSSH,.           |               |           |
| **15** | **Mod 4:** Scripting dengan Database (MySQL)   | OPTIONAL  | _LCLSSB_ - Bab 25                                                                  | **Setelah sesi ini, saya bisa:** Membuat _shell script_ yang bisa melakukan query secara langsung (seperti `SHOW TABLES` atau `INSERT`) ke dalam layanan _database_ MySQL,.                 |               |           |

---

### 3. PARKING LOT AWAL (Daftar Istilah Teknis)

Selama Anda membaca buku-buku referensi di atas, Anda mungkin akan menemukan istilah berikut. Gunakan daftar ini sebagai rujukan kilat Anda:

1. **Dependency:** Ketergantungan. Perangkat lunak lain (biasanya berupa _library_) yang dibutuhkan oleh sebuah program agar bisa diinstal dan berjalan.
2. **Mount Point:** Lokasi berupa folder di dalam hierarki direktori Linux yang digunakan untuk "menempelkan" dan mengakses perangkat penyimpanan (seperti _flashdisk_, partisi, harddisk baru).
3. **LVM (Logical Volume Manager):** Sebuah metode di Linux untuk memanajemen harddisk secara fleksibel. Alih-alih menggunakan partisi fisik yang kaku (sulit diperbesar ukurannya), LVM menggunakan partisi virtual (_logical_).
4. **Standard Input (stdin), Standard Output (stdout), Standard Error (stderr):** Tiga "aliran" data di terminal Linux. _Stdin_ adalah data yang Anda masukkan, _stdout_ adalah hasil perintah yang muncul di layar, dan _stderr_ adalah pesan _error_. Anda bisa "membelokkan" (redirection) aliran ini ke sebuah file menggunakan tanda `>`, `<` atau pipa `|`.
5. **Regular Expression (Regex):** Serangkaian simbol khusus untuk merepresentasikan pola teks secara spesifik (Contoh: menemukan semua alamat IP, atau menemukan teks yang hanya berawalan angka). Regex ibarat _Ctrl+F_ tapi menggunakan logika super.
6. **Daemon / Service:** Sebuah program yang berjalan di balik layar tanpa henti, biasanya menunggu untuk melayani permintaan jaringan atau sistem (contoh: _cron_ daemon, _ssh_ service, _web server_),.
7. **Subshell:** Saat Anda mengeksekusi sebuah _script_, terminal Linux "membelah diri" untuk memproses _script_ tersebut di sesi sementara (disebut subshell) agar tidak merusak lingkungan sesi utama Anda,.

---

**Saran Pendekatan Harian:** Karena Anda seorang pekerja keras yang bertugas di lapangan, manfaatkan _waktu jeda/istirahat_ di pekerjaan untuk mengeksekusi satu sesi (45 menit). Baca sekilas teorinya (15 menit), buka distrobox Anda dan langsung tirukan perintahnya (30 menit).

Fokus pada target yang ditandai **WAJIB** terlebih dahulu. Jika waktu Anda sangat terbatas minggu ini, loncati bagian OPTIONAL dan kembali lagi kelak saat Anda sudah di tahap wawancara kerja DevOps. Semoga berhasil, perjalanan Anda menuju SRE/DevOps dimulai dari baris _command_ berikutnya!