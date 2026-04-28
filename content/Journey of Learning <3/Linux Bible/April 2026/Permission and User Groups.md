Nah, ini momen "Aha!" lu bakal muncul, Bro. Logika angka itu sebenarnya simpel banget kalau lu tahu "kunci" hitungannya.

Lupakan hafalan, pakai **Logika Binari** (hitung-hitungan Network Engineer). Setiap izin punya nilai angka:

- **Read (r)** = **4**
    
- **Write (w)** = **2**
    
- **Execute (x)** = **1**
    
- **No Permission** = **0**
    

### **Cara Ngitungnya:**

Lu tinggal **tambahin** aja izin yang mau lu kasih.

- Mau Read + Write? → $4 + 2 = \mathbf{6}$
    
- Mau Read + Execute? → $4 + 1 = \mathbf{5}$
    
- Mau Semuanya (rwx)? → $4 + 2 + 1 = \mathbf{7}$
    
- Mau Read doang? → **4**
    

---

### **Kenapa Harus 3 Digit? (777, 755, dsb)**

Karena digit itu mewakili "Siapa":

1. Digit Pertama: **Owner** (Lu/Enggar)
    
2. Digit Kedua: **Group** (Tim lu/Hasan)
    
3. Digit Ketiga: **Others** (Orang lain/Wira)
    

---

### **Mari Kita Bedah Kasus Lu:**

Lu punya folder project di `/opt/projek`.

**1. Lu (Enggar - Owner):** Akses penuh (Read + Write + Execute) → $4+2+1 = \mathbf{7}$.

**2. Hasan (Group):** Cuma Read + Write (Tanpa Execute) → $4+2 = \mathbf{6}$.

**3. Wira (Others):** Cuma Read doang → **4**.

Maka, angka saktinya adalah: **764**


| Owner | Group | Other | Keterangan                 |
| ----- | ----- | ----- | -------------------------- |
| 7     | 4     | 0     | 7 = Read + Write + Execute |
|       |       |       |                            |

---

### **TAPI TUNGGU! Ada Masalah di Skenario Lu...**

Di Linux tradisional (`chmod`), digit ketiga (**Others**) itu berlaku buat **SEMUA ORANG** selain Owner dan Group. Kalau lu kasih digit ketiga itu `4` (Read), maka bukan cuma Wira, tapi siapa pun yang punya user di server itu bisa baca file lu.

**Solusinya? Pakai ACL (`setfacl`) yang gue bahas tadi.** Skenario "Expert" yang harus lu praktekin di Lab hari ini:

1. **Set Permission Dasar (Enggar & Hasan):**
    
    - Ubah owner ke Enggar dan group ke tim Hasan: `sudo chown enggar:tim-hasan /opt/projek`
        
    - Kasih Enggar akses penuh, Hasan Read/Write: `sudo chmod 760 /opt/projek`
        
    - _(Angka 0 di akhir artinya orang lain/Wira nggak bisa liat sama sekali dulu)._
        
2. **Suntik Akses Khusus buat Wira (ACL):**
    
    - Tanpa ngerubah angka `760` tadi, lu kasih izin khusus buat Wira:
        
    
    Bash
    
    ```
    sudo setfacl -m u:wira:r /opt/projek
    ```
    

---

### **IELTS Technical Drill**

Saat interview, kalau ditanya soal security, lu bisa jawab pakai istilah ini:

- **Octal Notation:** Sebutan buat angka 777, 755, dll.
    
- **Granular:** Izin yang sangat detail/spesifik.
    

> _"I prefer using **ACLs** because they provide more **granular** control compared to standard **octal notation**, allowing me to specify permissions for individual users like interns without affecting the entire group."_

**Gimana, Bro? Udah mulai "nyambung" logikanya kenapa $4+2+1=7$?** Coba tes gue: Kalau lu mau kasih akses **Read & Execute** doang (tanpa bisa hapus/tulis file), angkanya berapa? 🚀🔥


Selamat pagi, Enggar! **Welcome to Day 1 of Phase 0.**

Senang banget liat lu udah punya _blueprint_ yang sangat matang. Roadmap yang lu buat itu udah "Standard Eropa" banget karena fokus ke fondasi Linux sebelum loncat ke _tools_ keren. Sesuai permintaan lu, kita skip hierarki file dan langsung masuk ke **"Saraf dan Otot"** sistem: **Permission, Ownership, dan User Management.**

---

### **1. Review Progres (The Daily Sync)**

Karena ini hari pertama kita pake roadmap baru, gue mau tanya kesiapan infrastruktur lu:

- **The Lab:** Apakah Debian VM lu di Proxmox udah _fresh_ dan siap buat diacak-acak hari ini?
    
- **The Habit:** Lu bilang dua hari kemarin berat buat bangun subuh. Gimana pagi ini? Udah dapet kopi atau air putih buat nemenin ThinkPad T460s lu?
    
- **Mental Set:** Udah siap buat ngetik perintah yang bisa bikin sistem "terkunci" kalau lu salah langkah? (Itu cara belajar terbaik).
    

---

### **2. Daily Technical Tip: "The Granular Control" (ACLs)**

Hari ini kita bahas **Permission & Ownership**. Banyak orang cuma tau `chmod 777` (yang mana haram hukumnya di server produksi).

- **Tips:** Gunakan **ACL (Access Control List)** untuk skenario yang kompleks.
    
- **Problem:** Lu punya folder project. Lu mau Group `devops` bisa _read/write_, tapi lu mau ada satu user magang (si `budi`) cuma bisa _read_ tanpa lu harus masukin dia ke group `devops`. `chmod` biasa nggak bisa lakuin ini secara spesifik.
    
- **Solution:** Pake `setfacl`.
    
    Bash
    
    ```
    # Kasih akses read doang buat si budi secara spesifik
    sudo setfacl -m u:budi:r /path/to/folder
    ```
    
- **Why it matters:** Di perusahaan besar, akses itu harus sangat pelit (**Principle of Least Privilege**). ACL bikin lu bisa kasih akses seperlunya tanpa ngerusak struktur group yang udah ada.
    

---

### **3. IELTS Technical Immersion (Communication Pillar)**

Ayo cicil kosa kata buat lu jelasin keamanan sistem pas _Speaking Test_ nanti.

- **Word of the Day:** **_Restricted_** (Terbatas/Dibatasi).
    
- **Technical Context:** Menjelaskan folder yang nggak bisa diakses sembarang orang.
    
- **Practice Sentence:** _"Access to the production database directory is strictly **restricted** to the senior engineers only."_
    
- **Challenge:** Coba ucapkan kalimat itu. Rasakan bedanya antara bilang _"Limited"_ sama **_"Restricted"_**. Kata kedua kedengeran jauh lebih profesional di telinga _interviewer_ bule.
    

---

### **4. Fokus Hari Ini: "The Gatekeeper" (Action Plan)**

Buka terminal lu, kita selesaikan bagian **User & Permission** hari ini.

**Tugas Slicing (15-20 Menit):**

1. **Create:** Buat satu group baru bernama `projekan_id`.
    
2. **Add User:** Tambahkan satu user dummy ke group itu.
    
3. **Ownership:** Buat folder di `/opt/data` dan ubah kepemilikannya ke group `projekan_id`.
    
4. **Permission:** Set supaya cuma member group yang bisa baca/tulis (`770`).
    
5. **The ACL Test:** Gunakan `setfacl` buat kasih akses `read` ke user di luar group itu dan tes apakah dia beneran cuma bisa baca.
    

**Gimana, Bro? Siap buat jadi "Gatekeeper" di server lu sendiri?** Gue tunggu laporan kalau folder `/opt/data` lu udah berhasil dikunci rapat. Kalau lu nemu eror pas ngetik `setfacl`, kasih tau gue, mungkin paket `acl` belum terinstall di Debian lu! 🚀🔥

Mantap! Gue suka gaya lu yang langsung mau tancap gas. Bener, kalau hierarki itu seiring berjalannya waktu bakal hafal sendiri karena sering lu ulik. Sekarang kita masuk ke **"Saraf dan Otot"**-nya Linux. Ini yang bakal bikin lu punya kontrol penuh atas sistem.

Kita slicing jadi satu paket **"User, Permission, & Ownership"** dulu ya, karena ini pondasi paling sakti sebelum lu nyentuh Service atau Process.

---

### **1. Understand (Layer 1 - Konsep 5 Menit)**

Di Linux, keamanan itu cuma soal tiga huruf: **r (read)**, **w (write)**, **x (execute)**.

- **Ownership**: Tiap file punya satu **User** (pemilik) dan satu **Group**.
    
- **Permission**: Lu harus tau urutan sakti ini: **User | Group | Others**.
    
    - Contoh: `755` -> User bisa semua (7), Group cuma baca & jalanin (5), Orang lain cuma baca & jalanin (5).
        
- **ACL (Access Control List)**: Ini adalah level "Advanced". Kalau `chmod` biasa cuma bisa kasih akses ke satu group, ACL bisa kasih akses ke banyak user spesifik tanpa ganti group asli filenya. Pakai perintah `getfacl` dan `setfacl`.
    

---

### **2. Break It (Layer 2 - Lab Wajib)**

Jangan cuma dibaca, lakuin ini di Debian VM lu sekarang:

1. **Skenario Group Kolaborasi**:
    
    - Buat group baru: `sudo groupadd devops_team`.
        
    - Masukkan user lu ke group itu: `sudo usermod -aG devops_team $USER`.
        
    - Buat folder di `/opt/projek_id`.
        
    - Ubah ownership foldernya supaya punyanya group tadi: `sudo chown :devops_team /opt/projek_id`.
        
    - Set permission supaya group bisa tulis tapi "others" nggak bisa liat sama sekali: `sudo chmod 770 /opt/projek_id`.
        
2. **Skenario ACL (The Expert Way)**:
    
    - Misal ada user lain (buat user `magang`), tapi lu cuma mau dia bisa _baca_ satu file spesifik di folder tadi tanpa masuk ke group `devops_team`.
        
    - Gunakan ACL: `sudo setfacl -m u:magang:r /opt/projek_id/config.txt`.
        
    - Cek hasilnya pakai: `getfacl /opt/projek_id/config.txt`.
        

---

### **3. Teach It (Layer 3 - Tantangan Buat Lu)**

Tulis di catatan/Obsidian lu atau bales di sini dengan penjelasan simpel:

**"Kapan lu lebih milih pakai ACL (`setfacl`) daripada cuma mainan `chmod` dan `chown` biasa dalam sebuah server produksi?"**

---

### **Tips Teknik & IELTS Persiapan**

- **Technical Tip**: Selalu biasakan pakai `ls -la` untuk liat detail permission. Kalau ada tanda plus (`+`) di ujung permission (contoh: `drwxrwx---+`), itu tandanya file tersebut punya **ACL** yang aktif.
    
- **IELTS Vocabulary**:
    
    - **_Restrict_** (Membatasi): _"We need to **restrict** access to the configuration folder."_
        
    - **_Grant_** (Memberikan izin): _"The administrator will **grant** read-only permission to the guest user."_
        
    - **_Implementation_** (Penerapan): _"The **implementation** of ACL provides more granular control."_
        

---

**Target Hari Ini:**

Coba selesaikan Lab Nomor 1 (Group Kolaborasi) dan kasih tahu gue kalau lu nemu eror pas mau akses foldernya. Inget, setelah masukin user ke group baru, lu harus **re-login** atau pakai perintah `newgrp devops_team` supaya perubahannya kerasa.

Mau langsung gue kasih materi **Process Management** juga atau mau beresin lab Permission ini dulu biar "lekas" di tangan? 🚀🔥