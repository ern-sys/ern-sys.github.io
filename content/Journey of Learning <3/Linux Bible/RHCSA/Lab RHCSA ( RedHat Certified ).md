Sip. Ini yang lo butuhin—**lab RHCSA rasa “dunia kerja”**, bukan sekadar hafalan. Gue bikin kayak lo lagi jadi sysadmin kampus: server harus jalan, user harus bisa kerja, dan kalau salah config… ya chaos 😏

Target: pakai AlmaLinux / Rocky Linux di VM (mirip Red Hat Enterprise Linux)

---

# 🧪 SCENARIO: “Campus Internal Server”

Lo adalah admin. Tugas lo:

- setup server internal
    
- manage user
    
- secure system
    
- deploy service (web + SSH)
    
- storage rapi
    
- SELinux aktif (ini killer)
    

---

# ⚙️ LAB SETUP (WAJIB)

Bikin 1 VM:

- OS: AlmaLinux / Rocky
    
- RAM: min 2GB
    
- Disk: 20GB
    
- Network: NAT + (opsional) Host-only
    

Login sebagai root / sudo user.

---

# 🔥 TASK 1 — BASIC SYSTEM CONFIG

**Objective:** server siap dipakai

```bash
hostnamectl set-hostname server-campus
timedatectl set-timezone Asia/Jakarta
```

Edit hosts:

```bash
nano /etc/hosts
```

Tambahin:

```
127.0.0.1 server-campus
```

---

# 👥 TASK 2 — USER & GROUP (REAL CASE)

**Case:** Ada 2 divisi: IT dan Staff

```bash
groupadd it
groupadd staff

useradd -m -G it admin1
passwd admin1

useradd -m -G staff user1
passwd user1
```

Bikin shared folder:

```bash
mkdir /shared
chown :it /shared
chmod 2770 /shared
```

👉 efeknya:

- cuma grup IT bisa akses
    
- file otomatis ikut grup
    

---

# 💾 TASK 3 — STORAGE (INI SERING KELUAR)

**Case:** Tambahin disk baru buat data

Simulasi:

```bash
lsblk
```

Misal disk baru: `/dev/sdb`

```bash
fdisk /dev/sdb
```

- n → new partition
    
- w → write
    

Format:

```bash
mkfs.xfs /dev/sdb1
```

Mount:

```bash
mkdir /data
mount /dev/sdb1 /data
```

Permanent:

```bash
blkid
```

Edit:

```bash
nano /etc/fstab
```

---

# 🌐 TASK 4 — NETWORK (STATIC IP)

```bash
nmcli con show
nmcli con mod <interface> ipv4.addresses 192.168.1.100/24
nmcli con mod <interface> ipv4.gateway 192.168.1.1
nmcli con mod <interface> ipv4.method manual
nmcli con up <interface>
```

---

# 🔐 TASK 5 — SSH HARDENING

Edit:

```bash
nano /etc/ssh/sshd_config
```

Ubah:

```
PermitRootLogin no
PasswordAuthentication yes
```

Restart:

```bash
systemctl restart sshd
```

---

# 🌍 TASK 6 — WEB SERVER (REAL SERVICE)

Install:

```bash
dnf install httpd -y
```

Start:

```bash
systemctl enable --now httpd
```

Test:

```bash
curl localhost
```

Custom page:

```bash
echo "Welcome to Campus Server" > /var/www/html/index.html
```

---

# 🔥 TASK 7 — FIREWALL (WAJIB HIDUP)

```bash
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=ssh --permanent
firewall-cmd --reload
```

---

# 🛡️ TASK 8 — SELINUX (INI PENENTU LO LULUS ATAU ENGGAK)

Cek:

```bash
getenforce
```

Kalau enforcing → lanjut.

Misal web pakai folder custom:

```bash
mkdir /webdata
echo "Hello SELinux" > /webdata/index.html
```

Set context:

```bash
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
restorecon -Rv /webdata
```

Edit config Apache:

```bash
nano /etc/httpd/conf/httpd.conf
```

Ubah DocumentRoot ke `/webdata`

Restart:

```bash
systemctl restart httpd
```

---

# 🔄 TASK 9 — PROCESS & TROUBLESHOOTING

Simulasi:

```bash
top
ps aux
kill -9 <PID>
```

Cek log:

```bash
journalctl -xe
```

---

# ⏱️ BONUS (MODE UJIAN SIMULASI)

Coba kerjain tanpa lihat catatan:

- bikin user + grup
    
- setup LVM (lebih advance)
    
- deploy web server
    
- set SELinux bener
    
- troubleshooting kalau web gak bisa diakses
    

---

# 🧠 MINDSET YANG HARUS LO PEGANG

RHCSA itu bukan:

> “hafal command”

Tapi:

> “tau harus ngapain saat server rusak”

---

# 🚀 NEXT LEVEL (kalau lo serius banget)

Nanti kita bisa lanjut:

- LVM advanced
    
- cron job automation
    
- bash scripting
    
- Ansible (biar masuk DevOps juga)
    

---

Kalau lo mau, gue bisa bikinin:  
👉 versi **“exam simulator 2 jam”** (kayak ujian beneran, full pressure)  
👉 atau bikin **topologi 3 server (client–server–backup)**

Tinggal bilang:  
**“gas exam mode”** 😏