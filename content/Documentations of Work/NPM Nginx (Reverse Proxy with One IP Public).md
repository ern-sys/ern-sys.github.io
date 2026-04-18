# Install NPM via Docker — From Scratch

## Step 1 — Bersihkan yang Tadi

```bash
cd /opt
rm -rf npm
mkdir npm && cd npm
```

---

## Step 2 — Install Docker

```bash
# Install dependencies
apt install -y ca-certificates curl gnupg lsb-release

# Tambah Docker GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Tambah Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Cek docker jalan
docker --version
docker compose version
```

---

## Step 3 — Buat docker-compose.yml

```bash
nano /opt/npm/docker-compose.yml
```

Isi dengan ini:

```yaml
version: '3.8'
services:
  npm:
    image: jc21/nginx-proxy-manager:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "81:81"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

Save: `CTRL+X` → `Y` → `Enter`

---

## Step 4 — Jalankan NPM

```bash
cd /opt/npm
docker compose up -d
```

Tunggu sampai selesai pull image. Cek apakah jalan:

```bash
docker compose ps
```

Output yang diharapkan:

```
NAME    STATUS          PORTS
npm     Up X seconds    0.0.0.0:80->80, 0.0.0.0:443->443, 0.0.0.0:81->81
```

---

## Step 5 — Akses GUI NPM

Buka browser: `http://10.10.10.20:81`

```
Email    : admin@example.com
Password : changeme
```

**Langsung ganti email dan password** setelah login pertama.

---

## Step 6 — Port Forward di MikroTik

Masuk Winbox atau terminal MikroTik:

```routeros
/ip firewall nat

add chain=dstnat dst-address=PUBLIC-IP-LO \
    protocol=tcp dst-port=80 \
    action=dst-nat to-addresses=10.10.10.20 to-ports=80 \
    comment="NPM HTTP"

add chain=dstnat dst-address=PUBLIC-IP-LO \
    protocol=tcp dst-port=443 \
    action=dst-nat to-addresses=10.10.10.20 to-ports=443 \
    comment="NPM HTTPS"
```

> Port 81 jangan di-forward ke public.

---

## Step 7 — Tambah Service ke NPM

Ini alur yang lo ulangi setiap kali mau expose service baru.

**Login NPM → Proxy Hosts → Add Proxy Host**

Contoh untuk Grafana:

```
Domain Names    : grafana.domainlo.my.id
Scheme          : http
Forward Host    : 10.10.10.11
Forward Port    : 3000
Websockets      : ON
```

Tab SSL:

```
Request new SSL Certificate
Force SSL   : ON
HTTP/2      : ON
Email       : emaillo@gmail.com
```

Save. Tunggu 30 detik. Done — HTTPS otomatis aktif.

---

## Referensi Port Service Lo

|Subdomain|Forward IP|Port|
|---|---|---|
|`grafana.domain.lo`|10.10.10.11|3000|
|`dns.domain.lo`|10.10.10.12|80|
|`complaint.domain.lo`|10.10.10.16|80|
|`eve.domain.lo`|10.10.10.77|80|

---

## Checklist

```
[ ] Docker terinstall, docker --version jalan
[ ] docker compose up -d sukses
[ ] NPM bisa diakses di http://10.10.10.20:81
[ ] Password admin sudah diganti
[ ] Port forward MikroTik sudah aktif
[ ] Domain sudah pointing ke public IP
[ ] Minimal 1 proxy host sudah jalan + SSL issued
```

---


# Step yang harusnya tidak di lupakan.
# Tutorial Full: Reverse Proxy + 1 Public IP dari Nol sampai Jalan

Gue bagi jadi beberapa fase biar lo nggak overwhelmed. Jalanin satu fase dulu, baru lanjut ke berikutnya.

---

## FASE 0 — Persiapan Domain

### Opsi Domain (pilih salah satu)

**Gratis dulu buat testing:**

- Daftar di [duckdns.org](https://duckdns.org/)
- Login via GitHub/Google
- Buat subdomain: `namalo.duckdns.org`
- Pointing ke Public IP lo

**Berbayar buat produksi:**

- [rumahweb.com](https://rumahweb.com/) atau [niagahoster.co.id](https://niagahoster.co.id/)
- Beli `.my.id` — paling murah ~Rp15rb/tahun
- Setelah aktif, masuk ke DNS Management

Setelah punya domain, buat A record:

```
A   @               →   PUBLIC-IP-LO
A   *               →   PUBLIC-IP-LO   ← wildcard, penting!
```

Wildcard `*` artinya semua subdomain otomatis pointing ke IP lo. Jadi `grafana.domain.lo`, `panel.domain.lo`, apapun — semua masuk ke NPM lo tanpa harus tambah DNS record satu-satu.

---

## FASE 1 — Buat LXC untuk NPM di Proxmox

### 1.1 Download Template Debian 12

Di Proxmox UI:

- **local storage → CT Templates → Templates**
- Search `debian-12`
- Download

### 1.2 Buat LXC Container

**Create CT** dengan setting:

```
Hostname    : npm-proxy
Template    : debian-12
Disk        : 8GB
CPU         : 1 core
RAM         : 512MB
Swap        : 512MB
Network     : vmbr0, IP statis 10.10.10.20/24 (Misalkan)
Gateway     : 10.10.10.10
DNS         : 10.10.10.12 (Unbound lo sendiri)
Unprivileged: YES
```

Start LXC, masuk console.

### 1.3 Install NPM

```bash
# Update system
apt update && apt upgrade -y

# Install dependencies
apt install -y curl wget gnupg2 python3 make g++ gcc nginx

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Install MariaDB
apt install -y mariadb-server
mysql_secure_installation
```

Setup database:

```bash
mysql -u root -p
```

```sql
CREATE DATABASE npm;
CREATE USER 'npm'@'localhost' IDENTIFIED BY 'gantipasswordini';
GRANT ALL PRIVILEGES ON npm.* TO 'npm'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

Download dan install NPM:

```bash
mkdir /opt/npm && cd /opt/npm

wget https://github.com/NginxProxyManager/nginx-proxy-manager/archive/refs/tags/v2.11.3.tar.gz

tar -xzvf v2.11.3.tar.gz
cd nginx-proxy-manager-2.11.3

# Buat config
cat > config/production.json << 'EOF'
{
  "database": {
    "engine": "mysql",
    "host": "127.0.0.1",
    "name": "npm",
    "user": "npm",
    "password": "gantipasswordini",
    "port": 3306
  }
}
EOF

# Install dan build
npm install
npm run build
```

Buat systemd service:

```bash
cat > /etc/systemd/system/npm.service << 'EOF'
[Unit]
Description=Nginx Proxy Manager
After=network.target mariadb.service

[Service]
Type=simple
WorkingDirectory=/opt/npm/nginx-proxy-manager-2.11.3
ExecStart=/usr/bin/node index.js
Restart=always
RestartSec=5
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable npm
systemctl start npm
```

Cek status:

```bash
systemctl status npm
```

Akses GUI: `http://10.10.10.20:81` Login: `admin@example.com` / `changeme` → **langsung ganti password!**

---

## FASE 2 — Port Forward di MikroTik

```routeros
/ip firewall nat

# HTTP
add chain=dstnat dst-address=PUBLIC-IP-LO \
    protocol=tcp dst-port=80 \
    action=dst-nat to-addresses=10.10.10.20 to-ports=80 \
    comment="NPM - HTTP"

# HTTPS
add chain=dstnat dst-address=PUBLIC-IP-LO \
    protocol=tcp dst-port=443 \
    action=dst-nat to-addresses=10.10.10.20 to-ports=443 \
    comment="NPM - HTTPS"
```

> ⚠️ Port 81 (admin NPM) **jangan di-forward** ke public. Akses admin hanya dari jaringan internal.

---

## FASE 3 — Tambah Service ke NPM

Ini bagian yang akan lo ulangi setiap kali ada service baru.

### Contoh: Expose Grafana

1. Login NPM → **Proxy Hosts → Add Proxy Host**
2. Isi:

```
Domain Names   : grafana.domainlo.my.id
Scheme         : http
Forward Host   : 10.10.10.11
Forward Port   : 3000
Websockets     : ON (Grafana butuh ini)
```

3. Tab **SSL**:

```
SSL Certificate    : Request a new SSL Certificate
Force SSL          : ON
HTTP/2 Support     : ON
Email              : email@lo.com
```

4. **Save** → tunggu ~30 detik → SSL otomatis issued.

### Ulangi untuk semua service Nusa Putra lo:

|Domain|Forward IP|Port|
|---|---|---|
|`grafana.domain.lo`|10.10.10.11|3000|
|`dns.domain.lo`|10.10.10.12|80|
|`complaint.domain.lo`|10.10.10.16|80|
|`eve.domain.lo`|10.10.10.77|80|

---

## FASE 4 — Tambah Service Bisnis (SSH/VPS Panel)

Ini nanti setelah Nusa Putra beres. Alurnya sama persis:

1. Buat VM baru di Proxmox (misal `10.10.10.50`)
2. Install panel di VM itu (3X-UI, Marzban, dll)
3. Di NPM, tambah proxy host baru:

```
Domain Names   : panel.domainlo.my.id
Forward Host   : 10.10.10.50
Forward Port   : 2053 (port default 3X-UI)
SSL            : ON
```

Selesai — panel bisnis lo langsung bisa diakses publik via HTTPS.

---

## Checklist Progress

```
FASE 0 - Domain
[ ] Punya domain (DuckDNS atau .my.id)
[ ] A record @ dan * sudah pointing ke public IP

FASE 1 - NPM
[ ] LXC berjalan di 10.10.10.20
[ ] NPM bisa diakses di :81
[ ] Password admin sudah diganti

FASE 2 - MikroTik
[ ] Port forward 80 dan 443 aktif
[ ] Test dari luar: http://domainlo.my.id bisa diakses

FASE 3 - Service Nusa Putra
[ ] Grafana sudah bisa diakses via subdomain + SSL
[ ] Service lain menyusul

FASE 4 - Bisnis
[ ] VM panel bisnis siap
[ ] Proxy host bisnis ditambah di NPM
```

---

Mulai dari **Fase 0 dulu** — beli domain, setup DNS. Sambil nunggu propagasi DNS (bisa 5 menit sampai 1 jam), lo bisa mulai setup LXC di Proxmox. Kabarin gue kalau udah sampai mana, kita debug bareng kalau ada yang nyangkut.