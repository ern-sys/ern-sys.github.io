Sangat bisa dimengerti. Pendekatan yang komprehensif dan fundamental memang jauh lebih solid, terutama jika Anda ingin menguasai MikroTik (_RouterOS_) secara _expert_ layaknya Anda menguasai ekosistem Linux.

Berikut adalah silabus lengkap dan tidak terkompresi dari jalur pembelajaran MikroTik, disusun berdasarkan kurikulum sertifikasi resmi dari MikroTik yang ada pada sumber materi. Jalur ini dibagi menjadi tiga tingkatan: **Dasar (Associate)**, **Menengah (Engineer)**, dan **Ahli (Inter-Networking)**.

---

### TAHAP 1: FOUNDATION (MTCNA - MikroTik Certified Network Associate)

Tahap ini adalah gerbang wajib untuk memahami arsitektur dasar, navigasi, dan logika dasar _RouterOS_. Karena Anda berlatar belakang Linux, perhatikan baik-baik bagaimana _RouterOS_ mengadopsi fitur jaringan berbasis _kernel_ Linux.

**Modul 1: Pengenalan & Administrasi Sistem**

- **Arsitektur Perangkat:** Mengenal _RouterOS_ (Sistem Operasi) vs _RouterBOARD_ (Perangkat Keras).
- **Akses & Manajemen:** Login melalui Console/CLI (berbasis struktur hirarki), WinBox, WebFig, dan MAC-Telnet.
- **Instalasi & Recovery:** Instalasi via CD/USB, menggunakan _Netinstall_ untuk pemulihan sistem (mirip _PXE Boot_), dan reset konfigurasi.
- **Manajemen Lisensi:** Memahami batasan _Level_ Lisensi 0 hingga 6.
- **User Management:** Konfigurasi grup otorisasi lokal (_Full, Read, Write_) dan _Policy_ spesifik (seperti akses SSH, FTP, Winbox).

**Modul 2: Konektivitas & Dasar TCP/IP**

- **Model OSI & TCP/IP:** Memahami ulang fungsi _Layer_ 1 hingga 7, IPv4 _Addressing_, Subnetting, dan pengkabelan.
- **ARP (Address Resolution Protocol):** Cara kerja tabel ARP, pengikatan MAC ke IP (_ARP Reply_), dan mode _reply-only_ untuk keamanan.
- **DHCP & DNS:** Konfigurasi DHCP Server & Client, DHCP _Leases_, dan implementasi DNS _Cache_ lokal.

**Modul 3: Konsep Layer 2 (Bridging & Switching)**

- **Bridging:** Menggabungkan beberapa antarmuka (_interface_) ke dalam satu segmen _broadcast_ yang sama secara _software_.
- **Switching:** Penggunaan _Switch Chip_ / _Master Port_ untuk _switching_ berbasis _hardware_ (mengurangi beban CPU _router_).

**Modul 4: Fundamental Routing**

- **Konsep Routing:** Memahami _Routed Network_, tabel _routing_ (Tanda DAC, AS), dan kalkulasi _Gateway_.
- **Static Routing:** Mengatur rute statis, _Default Route_ (0.0.0.0/0), dan metrik dasar (_Distance_) untuk menentukan prioritas rute.

**Modul 5: Jaringan Nirkabel (Wireless 802.11)**

- **Konsep RF:** Standar 802.11 a/b/g/n/ac, regulasi spektrum (_Country Regulation_), band, dan lebar kanal (_Channel Width_).
- **Mode Operasi:** _AP-Bridge_ (Pemancar), _Station_ (Penerima), dan limitasi koneksi MAC menggunakan _Access List_ / _Connect List_.
- **Keamanan Wireless:** Implementasi WPA/WPA2-PSK dan algoritma enkripsi (AES/TKIP).

**Modul 6: Firewall Dasar & NAT**

- **Firewall Filter:** Memahami prinsip kerja logika IF-THEN, urutan eksekusi (_top-to-bottom_), dan rantai _Input, Forward_, serta _Output_.
- **Connection Tracking:** Analisis status paket (_New, Established, Related, Invalid_).
- **Network Address Translation (NAT):** Penggunaan _Source NAT (Masquerade)_ untuk akses internet klien, dan _Destination NAT (Port Forwarding)_ untuk mengekspos server lokal ke luar.

**Modul 7: Quality of Service (QoS) Dasar**

- **Simple Queue:** Membatasi target _Upload_ dan _Download_ (_Target Address_), limitasi dasar (_Max-Limit_), dan kalkulasi otomatis per klien (_Burst_).

**Modul 8: Tunneling & VPN Dasar**

- **Point-to-Point Protocols:** Implementasi PPPoE (sering dipakai ISP), PPTP, SSTP, dan L2TP untuk koneksi VPN dan terowongan antar jaringan.

---

### TAHAP 2: ADVANCED ENGINEERING (Spesialisasi)

Setelah fondasi Anda kuat, Anda bisa mempelajari modul _Engineering_ secara terpisah sesuai kebutuhan spesifik Anda.

#### A. MTCTCE (Traffic Control Engineer) - _Wajib untuk SysAdmin/Network Admin_

Mempelajari analisis aliran paket secara mendalam dan manipulasi _bandwidth_.

- **Packet Flow Diagram:** Anatomi perjalanan paket data melintasi _Prerouting, Input, Forward, Output_, dan _Postrouting_. Memahami di titik mana paket diproses oleh _Mangle_, NAT, atau Queue.
- **Firewall Mangle:** Teknik menandai koneksi (_Connection Mark_), menandai paket (_Packet Mark_), dan menandai rute (_Route Mark_).
- **Layer 7 Protocol:** Mengklasifikasikan trafik menggunakan Regular Expression (RegEx) untuk mendeteksi _payload_ aplikasi spesifik pada Layer 7 (misal memblokir trafik _P2P/BitTorrent_).
- **Advanced QoS (HTB & PCQ):** Struktur antrean pohon (_Hierarchical Token Bucket_) untuk pembagian _bandwidth_ bertingkat (parent/child), penjaminan laju (_Limit-At_ vs _Max-Limit_), dan penggunaan algoritma _Per Connection Queue_ (PCQ) untuk membagi rata _bandwidth_ antar pengguna secara dinamis.
- **Web Proxy:** Konfigurasi _Transparent Proxy_, penyimpanan _Cache_, dan _Access Control List_ (URL Filtering).

#### B. MTCRE (Routing Engineer) - _Fokus pada Topologi Kompleks_

- **Advanced Static Routing:** Rekayasa redundansi menggunakan fitur _Check-Gateway_, penerapan ECMP (_Equal Cost Multi-Path_), _Policy Routing_, serta teknik mendeteksi kematian koneksi internet di sisi ISP menggunakan _Scope_ dan _Target Scope_.
- **Dynamic Routing (OSPF):** Teori _Link-State Algorithm_, implementasi pembagian batas _Single-Area_ dan _Multi-Area_ (_Backbone Area 0_, _Stub, NSSA_), manipulasi jarak/metrik (_OSPF Cost_), _Designated Router (DR)_, _LSA Types_, serta _Virtual Link_.

#### C. MTCWE (Wireless Engineer) - _Fokus Infrastruktur Nirkabel_

- **Modulasi Nirkabel:** Pengaturan lanjutan metrik nirkabel (_Data Rates, TX-Power, CCQ_).
- **Wireless Proprietary Protocol:** Modifikasi protokol khusus rancangan MikroTik yang mengalahkan kinerja _802.11_ standar untuk transmisi jarak jauh: **Nstreme** dan **NV2** (berbasis _TDMA_).
- **Topologi WDS & Mesh:** _Wireless Distribution System_ transparan dan pengaturan jaringan Mesh.
- **Manajemen Enterprise:** Pengenalan CAPsMAN (_Controlled Access Point system Manager_) untuk mengelola puluhan/ratusan AP terpusat.

#### D. MTCSE (Security) & MTCSWE (Switching)

- **Keamanan Ekstra (MTCSE):** Proteksi _Bootloader_, Mitigasi serangan (DDoS, Syn Flood), pengamanan DHCP (_Add ARP Leases, DHCP Alert_), eksploitasi kriptografi, IPSec lanjutan, dan IDS/IPS _patterns_.
- **Switching Terpusat (MTCSWE):** Pembelajaran murni komunikasi Layer 2, implementasi VLAN terkelola (_VLAN Filtering_ pada model perangkat keras CRS/Cloud Router Switch).

---

### TAHAP 3: EXPERT (MTCINE - Inter-Networking Engineer)

Bila Anda masuk ke arsitektur berskala Data Center atau Internet Service Provider (ISP). Tahapan ini mengharuskan Anda lulus modul MTCRE sebelumnya.

- **BGP (Border Gateway Protocol):** Protokol tata letak Internet dunia. Mempelajari _Autonomous System_ (AS), sesi jaringan internal (iBGP) dan lintas jaringan (eBGP), _Path Vector algorithm_, _BGP Attributes_, serta filter distribusi rute.
- **MPLS (Multiprotocol Label Switching):** Teknik penggantian _Header IP_ dengan _Label Forwarding_ berlapis (Layer 2.5) untuk menghindari beban komputasi CPU akibat pengecekan rute. Mempelajari LDP (_Label Distribution Protocol_) dan pemotongan loncatan rute (_Penultimate-hop-popping_).
- **VPLS & L3VPN:** Terowongan virtual tembus jaringan MPLS, menciptakan _Ethernet Bridge_ jarak jauh seolah-olah dua kantor berada di _switch_ fisik yang sama.
- **Traffic Engineering (TE):** Menggunakan _Resource Reservation Protocol_ (RSVP) dan hitungan rute dinamis (CSPF) untuk penentuan laju alokasi limitasi terdedikasi berskala benua.

---

**Cara Memulai Sama Seperti Mempelajari Linux:** Sama seperti Anda memulai Linux dari `ls`, `cd`, dan `chmod` lalu baru beranjak ke _iptables_ atau BIND9.

Mulailah dengan modul **MTCNA**. Lakukan eksplorasi di CLI-nya untuk melihat kemiripan strukturnya. Contoh: konsep _Firewall Filter / Mangle_ di MikroTik secara logis persis berjalan seperti `iptables -t filter` dan `iptables -t mangle`. Setelah MTCNA beres, prioritas kedua untuk seorang _SysAdmin_ mutlak pada **MTCTCE**, karena di sanalah rahasia membedah dan mengintervensi alur kerja pergerakan paket data jaringan itu dikupas habis.