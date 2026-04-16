# Bikin satu LXC

- Lebih bersih — kalau ada yang rusak, tinggal hapus LXC-nya
- Resource ringan — cukup 1 CPU + 512MB RAM
- Ini juga habit yang bener buat production mindset

---
**Struktur project:**

- `backup.sh` — script utama yang SSH ke router, download `.backup` + export `.rsc`, bikin folder tanggal otomatis, cleanup backup lama
- `Dockerfile` — Alpine Linux ringan dengan `sshpass` + `openssh`
- `docker-compose.yml` — konfigurasi container, mount NAS, env file
- `entrypoint.sh` — setup cron di dalam container, jalankan test backup pertama kali saat container start
- `.env` — tempat isi IP router + password (tidak masuk Git)
- `README.md` — panduan deploy step by step

---
Nah ketemu! Ini address list lengkap banget, gue bisa lihat semuanya.

**IP MikroTik yang kita pakai: `10.10.10.1`**

Itu interface **V100 - ServerFarm** — dan LXC 999 lo ada di segment `10.10.10.x` yang sama. Jadi koneksi backup-nya **lokal semua**, tidak perlu lewat internet.

---

Sekarang semua data sudah lengkap. Ini yang gue tau:

|Parameter|Value|
|---|---|
|MikroTik IP|`10.10.10.1`|
|NAS IP|`10.10.10.13`|
|SMB Share|`nusaputra`|
|LXC Docker|999 (backup-automation)|

---
### Step 1 — Install cifs-utils untuk mount SMB

```bash
apt update && apt install -y cifs-utils
```

### Step 2 — Buat folder mount point

```bash
mkdir -p /mnt/nas-nusaputra
```

### Step 3 — Mount NAS (ganti USER dan PASS)

```bash
mount -t cifs //10.10.10.13/nusaputra /mnt/nas-nusaputra \
  -o username=USERLO,password=PASSLO,uid=1000,gid=1000,vers=3.0
```

Test berhasil atau tidak:

```bash
ls /mnt/nas-nusaputra
# Harusnya muncul folder: Enggar Archives, autoked, dll
```

### Step 4 — Buat folder khusus backup MikroTik di NAS

```bash
mkdir -p /mnt/nas-nusaputra/mikrotik-backup
```

### Step 5 — Copy project ke LXC

```bash
mkdir -p /opt/mikrotik-backup
```

Dari **laptop lo**, copy file project-nya:

```bash
scp -r /path/to/mikrotik-backup/* root@10.10.10.20:/opt/mikrotik-backup/
# Ganti 10.10.10.20 dengan IP LXC 999 lo yang sebenarnya
```

---
NAS udah ke-mount sempurna di LXC 999! Gue bisa lihat semua folder termasuk `Enggar Archives` dan lainnya.

Sekarang lanjut langsung:

### Step 1 — Buat folder mikrotik-backup di NAS

```bash
mkdir -p /mnt/nas-nusaputra/mikrotik-backup
ls /mnt/nas-nusaputra/mikrotik-backup
# Harusnya kosong, tidak ada error
```

### Step 2 — Buat folder project di LXC

```bash
mkdir -p /opt/mikrotik-backup
cd /opt/mikrotik-backup
```

### Step 3 — Buat semua file langsung di LXC (copy paste satu per satu)

**File 1 — `.env`**

```bash
cat > .env << 'EOF'
ROUTER_NAME=mikrotik-utama
ROUTER_IP=10.10.10.1
ROUTER_USER=admin
ROUTER_PASS=GANTI_PASSWORD_MIKROTIK_LO
CRON_SCHEDULE=0 2 * * *
RETENTION_DAYS=30
TZ=Asia/Jakarta
EOF
```

> Ganti `GANTI_PASSWORD_MIKROTIK_LO` dengan password SSH MikroTik lo yang sebenarnya.

---

**File 2 — `backup.sh`**

```bash
curl -o backup.sh https://raw.githubusercontent.com/enggar/mikrotik-backup/main/backup.sh
```

Jalankan ini:

```bash
cat > backup.sh << 'SCRIPT'
#!/bin/bash
ROUTER_NAME="${ROUTER_NAME:-mikrotik-utama}"
ROUTER_IP="${ROUTER_IP:-10.10.10.1}"
ROUTER_USER="${ROUTER_USER:-admin}"
ROUTER_PASS="${ROUTER_PASS:-password}"
BACKUP_ROOT="${BACKUP_ROOT:-/backup}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"

log_ok()   { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [OK] $1"; }
log_err()  { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1"; }
log_info() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1"; }

DATE_FOLDER=$(date '+%Y-%m-%d')
BACKUP_DIR="${BACKUP_ROOT}/${ROUTER_NAME}/${DATE_FOLDER}"
BACKUP_FILENAME="${ROUTER_NAME}-${DATE_FOLDER}"

log_info "Membuat folder: ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}" || { log_err "Gagal buat folder"; exit 1; }

log_info "Cek koneksi ke ${ROUTER_IP}..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
    "${ROUTER_USER}@${ROUTER_IP}" "/system identity print" > /dev/null 2>&1
[ $? -ne 0 ] && { log_err "Tidak bisa konek ke ${ROUTER_IP}"; exit 1; }
log_ok "Koneksi OK"

log_info "Membuat .backup di router..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/system backup save name=${BACKUP_FILENAME}"
sleep 3

log_info "Download .backup..."
sshpass -p "${ROUTER_PASS}" scp -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}:/${BACKUP_FILENAME}.backup" \
    "${BACKUP_DIR}/${BACKUP_FILENAME}.backup"
[ $? -eq 0 ] && log_ok "File .backup tersimpan" || log_err "Gagal download .backup"

log_info "Export .rsc..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/export show-sensitive" \
    > "${BACKUP_DIR}/${BACKUP_FILENAME}.rsc"
[ $? -eq 0 ] && [ -s "${BACKUP_DIR}/${BACKUP_FILENAME}.rsc" ] \
    && log_ok "File .rsc tersimpan" || log_err "Gagal export .rsc"

log_info "Hapus .backup dari router..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/file remove [find name=${BACKUP_FILENAME}.backup]"

log_info "Cleanup backup lama (>${RETENTION_DAYS} hari)..."
find "${BACKUP_ROOT}/${ROUTER_NAME}" -maxdepth 1 -type d -name "????-??-??" \
    -mtime +${RETENTION_DAYS} -exec rm -rf {} \; 2>/dev/null

echo "========================================"
echo " Router : ${ROUTER_NAME} (${ROUTER_IP})"
echo " Lokasi : ${BACKUP_DIR}"
echo " .rsc   : $(du -sh ${BACKUP_DIR}/${BACKUP_FILENAME}.rsc 2>/dev/null | cut -f1)"
echo " .bak   : $(du -sh ${BACKUP_DIR}/${BACKUP_FILENAME}.backup 2>/dev/null | cut -f1)"
echo "========================================"
log_ok "Backup selesai!"
SCRIPT

chmod +x backup.sh
```

---

**File 3 — `entrypoint.sh`**

```bash
cat > entrypoint.sh << 'EOF'
#!/bin/bash
CRON_SCHEDULE="${CRON_SCHEDULE:-0 2 * * *}"
echo "Router: ${ROUTER_NAME} (${ROUTER_IP}) | Jadwal: ${CRON_SCHEDULE}"
printenv | grep -v "no_proxy" > /etc/environment
echo "${CRON_SCHEDULE} bash -c 'source /etc/environment && /usr/local/bin/backup.sh >> /var/log/mikrotik-backup.log 2>&1'" > /etc/crontabs/root
echo "[INFO] Test run pertama..."
/usr/local/bin/backup.sh
echo "[INFO] Cron berjalan. Pantau: docker logs -f mikrotik-backup"
exec crond -f -l 2
EOF

chmod +x entrypoint.sh
```

---

**File 4 — `Dockerfile`**

```bash
cat > Dockerfile << 'EOF'
FROM alpine:3.19
RUN apk add --no-cache bash openssh-client sshpass tzdata curl
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY backup.sh /usr/local/bin/backup.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/backup.sh /entrypoint.sh
RUN mkdir -p /backup
ENTRYPOINT ["/entrypoint.sh"]
EOF
```

---

**File 5 — `docker-compose.yml`**

```bash
cat > docker-compose.yml << 'EOF'
version: "3.8"
services:
  mikrotik-backup:
    build: .
    container_name: mikrotik-backup
    restart: unless-stopped
    env_file:
      - .env
    volumes:
      - /mnt/nas-nusaputra/mikrotik-backup:/backup
networks:
  default:
    driver: bridge
EOF
```

---

### Step 4 — Verifikasi semua file ada

```bash
ls -la /opt/mikrotik-backup
# Harusnya: .env, backup.sh, entrypoint.sh, Dockerfile, docker-compose.yml
```

Step disini sangat krusial karena seringkali credential antara VM dan Access seringkali di tolak. jika mengalami error, silahkan lanjutkan dengan step ini:
Nah sekarang udah bisa! Lanjut langsung —

**Dari dalam LXC, jalankan ini:

### Buat folder backup di NAS

```bash
mkdir -p /mnt/nas-nusaputra/mikrotik-backup
```

### Buat folder project

```bash
mkdir -p /opt/mikrotik-backup
cd /opt/mikrotik-backup
```

### Buat file `.env`

```bash
cat > .env << 'EOF'
ROUTER_NAME=mikrotik-utama
ROUTER_IP=10.10.10.1
ROUTER_USER=admin
ROUTER_PASS=GANTI_INI_PASSWORD_MIKROTIK
CRON_SCHEDULE=0 2 * * *
RETENTION_DAYS=30
TZ=Asia/Jakarta
EOF
```

> Ganti `GANTI_INI_PASSWORD_MIKROTIK` dengan password SSH MikroTik lo.

### Buat file `backup.sh`

```bash
cat > backup.sh << 'SCRIPT'
#!/bin/bash
ROUTER_NAME="${ROUTER_NAME:-mikrotik-utama}"
ROUTER_IP="${ROUTER_IP:-10.10.10.1}"
ROUTER_USER="${ROUTER_USER:-admin}"
ROUTER_PASS="${ROUTER_PASS:-password}"
BACKUP_ROOT="${BACKUP_ROOT:-/backup}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"

log_ok()   { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [OK] $1"; }
log_err()  { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1"; }
log_info() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1"; }

DATE_FOLDER=$(date '+%Y-%m-%d')
BACKUP_DIR="${BACKUP_ROOT}/${ROUTER_NAME}/${DATE_FOLDER}"
BACKUP_FILENAME="${ROUTER_NAME}-${DATE_FOLDER}"

log_info "Membuat folder: ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}" || { log_err "Gagal buat folder"; exit 1; }

log_info "Cek koneksi ke ${ROUTER_IP}..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
    "${ROUTER_USER}@${ROUTER_IP}" "/system identity print" > /dev/null 2>&1
[ $? -ne 0 ] && { log_err "Tidak bisa konek ke ${ROUTER_IP}"; exit 1; }
log_ok "Koneksi OK"

log_info "Membuat .backup di router..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/system backup save name=${BACKUP_FILENAME}"
sleep 3

log_info "Download .backup..."
sshpass -p "${ROUTER_PASS}" scp -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}:/${BACKUP_FILENAME}.backup" \
    "${BACKUP_DIR}/${BACKUP_FILENAME}.backup"
[ $? -eq 0 ] && log_ok "File .backup tersimpan" || log_err "Gagal download .backup"

log_info "Export .rsc..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/export show-sensitive" \
    > "${BACKUP_DIR}/${BACKUP_FILENAME}.rsc"
[ $? -eq 0 ] && [ -s "${BACKUP_DIR}/${BACKUP_FILENAME}.rsc" ] \
    && log_ok "File .rsc tersimpan" || log_err "Gagal export .rsc"

log_info "Hapus .backup dari router..."
sshpass -p "${ROUTER_PASS}" ssh -o StrictHostKeyChecking=no \
    "${ROUTER_USER}@${ROUTER_IP}" "/file remove [find name=${BACKUP_FILENAME}.backup]"

log_info "Cleanup backup lama (>${RETENTION_DAYS} hari)..."
find "${BACKUP_ROOT}/${ROUTER_NAME}" -maxdepth 1 -type d -name "????-??-??" \
    -mtime +${RETENTION_DAYS} -exec rm -rf {} \; 2>/dev/null

echo "========================================"
echo " Router : ${ROUTER_NAME} (${ROUTER_IP})"
echo " Lokasi : ${BACKUP_DIR}"
echo " .rsc   : $(du -sh ${BACKUP_DIR}/${BACKUP_FILENAME}.rsc 2>/dev/null | cut -f1)"
echo " .bak   : $(du -sh ${BACKUP_DIR}/${BACKUP_FILENAME}.backup 2>/dev/null | cut -f1)"
echo "========================================"
log_ok "Backup selesai!"
SCRIPT

chmod +x backup.sh
```

### Buat file `entrypoint.sh`

```bash
cat > entrypoint.sh << 'EOF'
#!/bin/bash
CRON_SCHEDULE="${CRON_SCHEDULE:-0 2 * * *}"
echo "Router: ${ROUTER_NAME} (${ROUTER_IP}) | Jadwal: ${CRON_SCHEDULE}"
printenv | grep -v "no_proxy" > /etc/environment
echo "${CRON_SCHEDULE} bash -c 'source /etc/environment && /usr/local/bin/backup.sh >> /var/log/mikrotik-backup.log 2>&1'" > /etc/crontabs/root
echo "[INFO] Test run pertama..."
/usr/local/bin/backup.sh
echo "[INFO] Cron berjalan. Pantau: docker logs -f mikrotik-backup"
exec crond -f -l 2
EOF

chmod +x entrypoint.sh
```

### Buat file `Dockerfile`

```bash
cat > Dockerfile << 'EOF'
FROM alpine:3.19
RUN apk add --no-cache bash openssh-client sshpass tzdata curl
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY backup.sh /usr/local/bin/backup.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/backup.sh /entrypoint.sh
RUN mkdir -p /backup
ENTRYPOINT ["/entrypoint.sh"]
EOF
```

### Buat file `docker-compose.yml`

```bash
cat > docker-compose.yml << 'EOF'
version: "3.8"
services:
  mikrotik-backup:
    build: .
    container_name: mikrotik-backup
    restart: unless-stopped
    env_file:
      - .env
    volumes:
      - /mnt/nas-nusaputra/mikrotik-backup:/backup
networks:
  default:
    driver: bridge
EOF
```

### Verifikasi semua file ada

```bash
ls -la /opt/mikrotik-backup
```

Harusnya muncul 5 file: `.env`, `backup.sh`, `entrypoint.sh`, `Dockerfile`, `docker-compose.yml`. Screenshot hasilnya ke gue, kita langsung `docker compose build`.

# Jika terdapat error terkait symbol.
Ketemu! Error-nya: **`expected end of command (line 1 column 9)`**

MikroTik tidak kenal syntax `/export show-sensitive` dengan cara itu. MikroTik RouterOS pakai syntax yang sedikit beda — `show-sensitive` harus dipisah atau pakai format yang berbeda tergantung versi RouterOS.

Coba test ini satu per satu:

```bash
# Opsi 1 — tanpa show-sensitive dulu
sshpass -p "(password)" ssh -o StrictHostKeyChecking=no -p 8889 enggar@10.10.10.1 "/export" | head -20
```

Kalau berhasil, coba:

```bash
# Opsi 2 — format berbeda
sshpass -p "(password)" ssh -o StrictHostKeyChecking=no -p 8889 enggar@10.10.10.1 "export show-sensitive" | head -20
```

Ini hasil nya nanti :

```
✅ Koneksi OK
✅ Configuration backup saved
✅ File .backup tersimpan  → 508.0K
✅ File .rsc tersimpan    → 37.5K
✅ Cleanup berjalan
✅ Cron berjalan
```

---

**Ya, sekarang backup jalan otomatis setiap hari jam 02:00 pagi** — selama container `mikrotik-backup` hidup.

Struktur yang terbentuk di NAS lo sekarang:

```
/nusaputra/mikrotik-backup/
└── mikrotik-utama/
    └── 2026-04-13/
        ├── mikrotik-utama-2026-04-13.rsc    (37.5K)
        └── mikrotik-utama-2026-04-13.backup (508K)
```

Besok otomatis terbuat folder `2026-04-14/` dengan isinya, lusa `2026-04-15/`, dst. Setelah 30 hari folder lama otomatis dihapus.

Verifikasi file sudah ada di NAS:

```bash
ls -la /mnt/nas-nusaputra/mikrotik-backup/mikrotik-utama/2026-04-13/
```

---

**Satu hal penting** — mount NAS belum permanent. Kalau Proxmox host reboot, mount hilang dan backup gagal. Kita perlu tambahkan ke `/etc/fstab` di Proxmox host.

Mantap, mindset yang bener! Kita fix fstab dulu, baru gue jelasin semuanya dari awal.

### Fix permanent mount — jalankan di Proxmox host

```bash
# SSH ke Proxmox host dulu
ssh root@10.10.10.10

# Buat file credentials SMB (lebih aman dari taruh di fstab langsung)
cat > /etc/cifs-credentials-nas << 'EOF'
username=User
password=Password
EOF

# Amankan file credentials (hanya root yang bisa baca)
chmod 600 /etc/cifs-credentials-nas

# Tambahkan ke fstab
echo "//10.10.xx.xx/nusaputra /mnt/nas-nusaputra cifs credentials=/etc/cifs-credentials-nas,uid=0,gid=0,vers=3.0,file_mode=0777,dir_mode=0777 0 0" >> /etc/fstab

# Test fstab tanpa reboot
mount -a

# Verifikasi
ls /mnt/nas-nusaputra/mikrotik-backup/
```

Kalau tidak ada error, test reboot:

```bash
reboot
```

Setelah Proxmox nyala lagi, masuk ke LXC 999 dan cek:

```bash
pct enter 999
ls /mnt/nas-nusaputra/mikrotik-backup/
docker ps
# Container mikrotik-backup harus Running
```
