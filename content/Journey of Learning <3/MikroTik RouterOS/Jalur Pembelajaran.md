Berikut adalah kurikulum terstruktur yang disesuaikan untuk Anda sebagai seorang _Network Engineer / SysAdmin_ menengah yang sudah familiar dengan ekosistem Linux. Mengingat RouterOS dibangun dengan basis arsitektur Linux, Anda akan merasa familiar dengan banyak konsep dasarnya (misal: _Firewall_ identik dengan `iptables`, _Queue_ identik dengan Linux `tc`, dan _Routing_ identik dengan `iproute2`).

### 1. PETA MODUL

**Modul 1: Pengenalan & Keamanan Dasar RouterOS** Menginstal dan mengakses sistem RouterOS, serta melakukan pengamanan perangkat sedari dini (manajemen _user_ dan grup). Berbekal pengetahuan Linux, Anda akan mudah beradaptasi dengan _Command Line Interface_ (CLI) milik MikroTik.

**Modul 2: Konektivitas Dasar & Manajemen _Layer_ 2** Membangun pondasi jaringan agar klien bisa saling terhubung dan berselancar ke internet. Modul ini meliputi _IP Address_, DHCP, DNS, NAT (_Masquerade_), dan fitur _Bridge_ untuk menggabungkan beberapa _port_ fisik menjadi satu _switch_ lojik.

**Modul 3: Konsep Routing & Failover Sederhana** Mengendalikan arus lalu lintas data antar jaringan yang berbeda _subnet_ melalui _Static Route_. Anda juga akan belajar membuat jalur cadangan (_failover_) dengan memanipulasi metrik jarak (_Distance_).

**Modul 4: Firewall Filter & Mangle** Menganalisis _packet flow_ dari Layer 3 hingga Layer 7 untuk melindungi _router_ dari serangan eksternal. Anda akan membedah modul _Mangle_ untuk menandai paket data, yang sangat krusial untuk fitur lanjutan seperti QoS dan _Load Balancing_.

**Modul 5: Traffic Control (QoS) & Bandwidth Management** Menerapkan skema _Quality of Service_ (QoS) agar pembagian _bandwidth_ merata. Modul ini fokus pada pemanfaatan algoritma PCQ (_Per Connection Queue_) dan pembagian kelas _bandwidth_ menggunakan struktur _HTB (Hierarchical Token Bucket)_.

**Modul 6: VPN & Tunneling** Membangun jaringan komunikasi yang aman antar berbagai lokasi dengan menggunakan infrastruktur jaringan publik (internet). Anda akan mengonfigurasi jalur _Point-to-Point Tunneling Protocol_ (PPTP) dan PPPoE.

**Modul 7: Routing Dinamis (Dynamic Routing)** Mengotomatiskan penyebaran tabel rute pada jaringan berskala masif. Modul tingkat lanjut ini memperkenalkan cara kerja OSPF (_Open Shortest Path First_) dengan _Single/Multi-Area_, serta perkenalan dasar protokol BGP (_Border Gateway Protocol_).

---

### 2. BREAKDOWN SESI HARIAN & 4. PRIORITAS

_(Setiap sesi diestimasi memakan waktu 45 menit untuk membaca dan simulasi Lab)_

| Sesi    | Modul | Prioritas | Tujuan Konkret Pembelajaran                                                                                                                                                                                     | Referensi (Buku / Modul)                                                 |
| :------ | :---- | :-------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------- |
| **1.1** | 1     | **WAJIB** | **Setelah sesi ini, saya bisa:** Melakukan instalasi RouterOS via Netinstall (saat _router_ bermasalah), serta mengakses _router_ menggunakan WinBox dan CLI.                                                   | _MTCNA Basic_ - Installation & Winbox; _MTCNA IDN_                       |
| **1.2** | 1     | **WAJIB** | **Setelah sesi ini, saya bisa:** Membuat konfigurasi pengamanan _router_ dasar seperti menonaktifkan _service_ rentan, mengamankan _Bootloader_, serta mengatur hak akses _User Group_ berdasar IP.             | _Security For Beginner's_ - Protected Bootloader & Policies; _MTCNA IDN_ |
| **2.1** | 2     | **WAJIB** | **Setelah sesi ini, saya bisa:** Memasang IP Address, mengaktifkan DHCP Server, menyetel DNS _Cache_, serta mengonfigurasi `src-nat` dengan aksi _Masquerade_ untuk memberikan akses internet ke LAN klien.     | _MTCNA IDN_ - Basic Config, DHCP, & NAT; _MTCNA Basic_                   |
| **2.2** | 2     | **WAJIB** | **Setelah sesi ini, saya bisa:** Menggabungkan 2 atau lebih _interface Ethernet_ menjadi satu segmen _broadcast_ (_Layer 2_) menggunakan fitur _Bridge_.                                                        | _MTCNA Basic_ - Bridge & Switch                                          |
| **3.1** | 3     | **WAJIB** | **Setelah sesi ini, saya bisa:** Menambahkan _Static Route_ secara manual (termasuk 0.0.0.0/0) untuk memastikan klien dapat berkomunikasi ke jaringan luar dan internet.                                        | _MTCRE_ - Static Route; _Dapur'e Mikrotik_ - Static Routing              |
| **3.2** | 3     | Opsional  | **Setelah sesi ini, saya bisa:** Membuat sistem redundansi (_Fail Over_) koneksi internet yang secara otomatis berpindah jalur jika _Gateway_ utama mati menggunakan fitur _Check Gateway Ping_ dan _Distance_. | _MTCRE_ - Fail Over & Target Scope; _Dapur'e Mikrotik_ - Lab 8/10        |
| **4.1** | 4     | **WAJIB** | **Setelah sesi ini, saya bisa:** Menerapkan skema logika IF-THEN pada _Firewall Filter_ di urutan (chain) _Input_ dan _Forward_ untuk memblokir akses ilegal dan menyimpan _Log_ ancaman.                       | _MTCNA IDN_ - Firewall; _Advanced Traffic Control_                       |
| **4.2** | 4     | **WAJIB** | **Setelah sesi ini, saya bisa:** Membaca diagaram _Packet Flow_ dan mencegat lalu lintas spesifik untuk diberikan penandaan jaringan (_Packet/Connection Mark_) melalui _Firewall Mangle_.                      | _MTCTCE_ - Packet Flow & Mangle                                          |
| **5.1** | 5     | **WAJIB** | **Setelah sesi ini, saya bisa:** Mengonfigurasi antrean otomatis menggunakan perpaduan _Simple Queue_ dan tipe _PCQ_ untuk membagi rata _bandwidth_ internet ke banyak _user_ secara adil.                      | _MTCNA IDN_ - QoS & PCQ; _MTCTCE_ - QoS                                  |
| **5.2** | 5     | Opsional  | **Setelah sesi ini, saya bisa:** Menerapkan _Quality of Service_ skala lanjut dengan mengatur garansi alokasi _bandwidth_ (_Limit-At_) dan batas batas puncak (_Max-Limit_) menggunakan hierarki _HTB_.         | _MTCTCE_ - HTB Distribution; _MTCNA IDN_                                 |
| **6.1** | 6     | Opsional  | **Setelah sesi ini, saya bisa:** Membangun _Virtual Private Network_ dan _Tunnel_ (PPTP/PPPoE) serta mengintegrasikan _Static Route_ agar dua buah kantor bisa bertukar data privat.                            | _MTCNA IDN_ - Tunneling & VPN; _MTCRE_ - IP Tunnel                       |
| **7.1** | 7     | Opsional  | **Setelah sesi ini, saya bisa:** Menerapkan protokol OSPF dalam _Single Area_ (_Backbone_) dan memilih _Designated Router_ secara dinamis untuk distribusi tabel _routing_.                                     | _MTCRE_ - OSPF; _Dapur'e Mikrotik_ - Lab 18                              |
| **7.2** | 7     |  Lanjut   | **Setelah sesi ini, saya bisa:** Mengonfigurasi identitas _Autonomous System_ (AS) dan melakukan _Peering BGP_ antar penyedia layanan (_ISP_) menggunakan _eBGP_ / _iBGP_.                                      | _MTCRE_ - BGP Basic                                                      |

---

### 3. PARKING LOT AWAL (Glosarium Khas MikroTik)

Sebagai _SysAdmin Linux_, Anda mungkin menemukan terminologi asing di buku materi karena MikroTik menggunakan kustomisasi internalnya. Jadikan tabel ini panduan rujukan cepat saat Anda mendapati istilah spesifik:

1. **WinBox:** Aplikasi native berbasis GUI khusus untuk manajemen MikroTik via Windows atau WINE (Linux) tanpa harus menggunakan peramban web atau SSH.
2. **Safe Mode:** Fitur krusial berbentuk tombol di GUI yang mencatat konfigurasi sementara. Apabila Anda melakukan kesalahan yang menyebabkan koneksi SSH/Winbox Anda terputus ke _router_, _Safe Mode_ secara otomatis akan me- _undo_ perintah tersebut hingga 15 menit ke belakang.
3. **Netinstall:** Utilitas penyelamat jaringan bawaan MikroTik (bisa via PXE Boot) yang digunakan untuk melakukan instalasi ulang _firmware_ jika _RouterOS_ mengalami gagal _booting_, korup, atau jika Anda terkunci akibat lupa kata sandi.
4. **Mangle:** Fasilitas pemrosesan di menu _Firewall_ (identik dengan `iptables -t mangle`) yang digunakan untuk memberikan tanda tak-kasat-mata (_mark_) pada koneksi, paket, atau lalu lintas rute. Wajib dikuasai jika ingin membuat aturan pembatasan lalu lintas (QoS) atau Load Balance canggih.
5. **PCQ (Per Connection Queue):** Algoritma antrean eksklusif MikroTik. PCQ bertugas membagi total alokasi _bandwidth_ secara dinamis kepada tiap alamat IP aktif yang muncul di jaringan agar tak ada klien yang memonopoli koneksi.
6. **HTB (Hierarchical Token Bucket):** Sebuah struktur metode pengaturan kecepatan. Ia memungkinkan peminjaman kelas _bandwidth_ dengan batasan jaminan _Committed Information Rate (CIR/Limit-at)_ dan nilai puncak _Maximum Information Rate (MIR/Max-limit)_.
7. **EoIP (Ethernet over IP):** Standar _tunnel_ proprieter MikroTik. Protokol ini bekerja di atas jaringan IP, namun mentransmisikan data dalam bentuk _Ethernet bridge Layer 2_ murni, memungkinkan dua kantor yang terpisah negara terasa seperti terhubung ke kabel LAN fisik (switch) yang sama.
8. **FastTrack:** Mode di dalam _Firewall_ yang memperbolehkan lalu lintas paket dari koneksi yang sudah _established_ (terjalin) untuk melewati tahapan inspeksi panjang. Dampaknya menurunkan beban CPU hingga 80% dan melipatgandakan _throughput_ kecepatan jaringan.