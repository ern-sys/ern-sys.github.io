Betul banget! Itu adalah **Foundational Step** (Langkah Dasar). Kalau kita visualisasikan, lu baru saja membangun "Rumah" dan memberikan "Kunci Pintu" untuk user lu sendiri.

Untuk menyambung dengan skenario **Grup IT** dan **Atasan** yang lu mau tadi, mari kita lengkapi strukturnya sampai tuntas.

Berikut adalah alur logis yang harus lu simpan di catatan (Obsidian) lu:

### **1. Membuat Identitas (User & Password)**

Langkah yang lu tulis sudah benar.

Bash

```
sudo useradd -m enggar   # Buat user Enggar + Folder Home
sudo passwd enggar       # Kasih password biar bisa login
```

### **2. Memberikan Kekuatan (Privileges)**

Supaya si `enggar` ini bisa jadi Admin (pakai `sudo`), lu harus daftarkan dia ke grup "Sakti" di Linux, yaitu grup **sudo**.

Bash

```
sudo usermod -aG sudo enggar
```

### **3. Membuat Organisasi (Group IT)**

Sekarang buat wadah untuk tim lu atau atasan lu nanti yang cuma boleh "lihat-lihat".

Bash

```
sudo groupadd IT
```

### **4. Membuat Wilayah Kerja (Directory)**

Lu buat folder yang mau diawasi.

Bash

```
sudo mkdir /opt/data-test
```

### **5. Menentukan Siapa Berkuasa (Ownership & Permission)**

Ini bagian yang paling krusial. Lu harus hubungkan Folder tadi dengan User dan Grupnya.

Bash

```
# Lu (enggar) sebagai pemilik, IT sebagai pengawas
sudo chown enggar:IT /opt/data-test

# Lu bebas ngapain aja (7), IT cuma bisa baca (4), Orang lain dilarang masuk (0)
sudo chmod 740 /opt/data-test
```

---

### **Kenapa Strukturnya Harus Begitu?**

Bayangkan lu di kantor:

1. **Useradd**: Lu rekrut karyawan baru.
    
2. **Usermod sudo**: Lu kasih dia kartu akses ke semua ruangan (Master Key).
    
3. **Groupadd**: Lu bikin divisi baru (Divisi IT).
    
4. **Chown**: Lu kasih tanggung jawab ruangan `/opt/data-test` ke Enggar dan tim IT.
    
5. **Chmod**: Lu pasang aturan: "Enggar boleh bongkar pasang barang (7), tim IT cuma boleh liat dari kaca (4)."
    

---

### **IELTS Technical Drill (Speaking Practice)**

Coba ucapkan ini untuk melatih kelancaran bahasa Inggris teknis lu:

> _"The structure is simple. First, I **created** the user and **assigned** them to the sudo group. Then, I **established** a dedicated IT group and **configured** the directory permissions to ensure only authorized members can **access** the data."_

**Kosa kata penting:**

- **Established**: Mendirikan/Membuat.
    
- **Authorized**: Yang berwenang/punya izin.
    
- **Access**: Mengakses.
    

---

### **Evaluasi Subuh Ini:**

Lu udah paham konsep **User -> Group -> Ownership -> Permission**. Ini adalah pondasi **Phase 0** yang paling penting.

**Gimana, Bro?** Udah siap buat lanjut ke materi berikutnya (Process Management/Service) atau lu mau coba tes login pake user enggar dulu buat mastiin semuanya lancar? 🚀🔥