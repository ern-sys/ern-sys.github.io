## Gue Pegang Lu di Sini

Ini bukan roadmap biasa. Ini **blueprint dari nol sampai expert** — jujur, realistis, dan spesifik buat lu.

---

## Dulu, Lurusin Mindset Dulu

Sebelum roadmap, ini yang harus lu internalisasi:

> **Expert bukan tujuan akhir. Expert adalah hasil samping dari konsistensi yang panjang.**

Timeline jujurnya:

- **6 bulan** → Mulai percaya diri di satu area
- **1 tahun** → Bisa selesaikan masalah nyata tanpa banyak googling
- **2–3 tahun** → Level yang orang panggil "expert"

Nggak ada shortcut. Tapi ada **cara yang efisien vs cara yang buang waktu.** Gue kasih yang efisien.

---

## Satu Arah: Linux Infrastructure Engineer → DevOps/SRE

```
Junior SysAdmin
      ↓
Linux Infrastructure Engineer      ← Lu akan ada di sini dalam 1 tahun
      ↓
DevOps/Automation Engineer         ← Tahun ke-2
      ↓
Senior DevOps / SRE                ← Tahun ke-3
```

---

## Metode Belajar Lu — "The 3-Layer Method"

Ini yang membedakan orang yang jago vs yang cuma tau teori.

### Layer 1 — Understand (20% waktu)

Baca/tonton konsepnya. Jangan lebih dari 30 menit per sesi. Cukup sampai lu ngerti _apa_ dan _kenapa_.

### Layer 2 — Break It (60% waktu)

Langsung praktek di homelab. **Sengaja rusak. Sengaja salah.** Restore sendiri. Ini yang paling banyak ngajarin otak lu.

### Layer 3 — Teach It (20% waktu)

Tulis di blog lu. Jelaskan seolah lu ngajarin orang lain. Kalau lu nggak bisa jelasin dengan simpel, berarti lu belum ngerti.

> **Aturan keras: Nggak ada Layer 3 = materi itu belum selesai.**

---

## Roadmap Lengkap — Bertahap Sampai Expert

---

### 🔴 PHASE 0 — Fondasi Besi

#### April – Juni 2026 (3 bulan)

_"Sebelum berlari, pastikan kaki lu kuat."_

**Anchor skill: Linux CLI + Bash Scripting**

**Bulan 1 — April: Linux Core**

- Filesystem hierarchy (`/etc`, `/var`, `/proc`, `/sys`)
- Permission & ownership — chmod, chown, ACL
- User & group management
- Process management — ps, top, htop, kill, nice
- Systemd — start/stop/enable/disable/status service
- Journalctl — baca log dengan benar
- Cron & crontab — scheduled tasks
- Package management — apt, dpkg, snap

**Lab wajib bulan ini:**

- Setup fresh Debian VM di Proxmox lu
- Buat user baru, set permission folder, buat service systemd custom
- Jadwalkan backup folder pakai cron

---

**Bulan 2 — Mei: Networking dari Sisi Linux**

- `ip`, `ss`, `netstat`, `nmap`, `tcpdump`
- UFW / nftables — firewall dasar
- `/etc/hosts`, `/etc/resolv.conf`, DNS lookup tools
- SSH hardening — key-based auth, disable root login, fail2ban
- Wireshark — analisis traffic dasar

**Lab wajib:**

- Hardening SSH di semua VM Proxmox lu
- Setup fail2ban
- Analisis traffic DNS di homelab pakai tcpdump

---

**Bulan 3 — Juni: Bash Scripting**

- Variable, kondisi, loop, fungsi
- Argumen & input handling
- File parsing — awk, sed, grep, cut
- Error handling di script
- Logging output script ke file

**Lab wajib:**

- Bikin script monitoring disk/CPU yang kirim alert
- Bikin script backup otomatis dengan rotasi file lama
- Automate user provisioning via script

---

### 🟡 PHASE 1 — Mulai Berbahaya

#### Juli – September 2026 (3 bulan)

_"Lu mulai bisa selesaikan masalah yang orang lain perlu googling lama."_

**Bulan 4 — Juli: Docker**

- Container vs VM — kapan pakai apa
- Dockerfile, image build, layer caching
- Docker Compose — multi-container stack
- Volume, network bridge/host/overlay
- Container logging & debugging

**Lab wajib:**

- Containerize complaint system lu di Proxmox
- Deploy stack: Nginx + App + Database pakai Compose
- Simulasi container crash — debug dan restore

---

**Bulan 5 — Agustus: Ansible**

- Inventory, playbook, task, handler
- Variables, facts, conditionals
- Roles & Galaxy
- Idempotency — kenapa ini penting

**Lab wajib:**

- Automate full setup Debian VM baru dari scratch
- Deploy dan configure Nginx + firewall pakai playbook
- Manage semua VM Proxmox lu pakai Ansible

---

**Bulan 6 — September: Git + CI/CD**

- Git branching, merge, rebase, conflict resolution
- GitHub Actions — workflow, triggers, jobs, secrets
- Pipeline: test → build → deploy

**Lab wajib:**

- Auto-deploy blog lu tiap push ke GitHub
- Bikin pipeline yang build Docker image dan push ke registry

---

### 🟢 PHASE 2 — Infrastructure as Code

#### Oktober – November 2026 (2 bulan)

**Bulan 7 — Oktober: Terraform**

- HCL syntax, provider, resource, variable, output
- State file — local & remote
- Terraform + Proxmox provider

**Lab wajib:**

- Provision VM baru di homelab lu pakai `terraform apply`
- Destroy dan recreate — pastikan reproducible

---

**Bulan 8 — November: Cloud Entry**

- AWS core: EC2, S3, VPC, IAM, Route53, Security Groups
- Deploy sesuatu nyata di free tier
- **Target: Lulus AWS Cloud Practitioner**

**Lab wajib:**

- Deploy static site di S3
- Setup VPC dengan public/private subnet
- Ujian sertifikasi

---

### 🔵 PHASE 3 — Solidify & Specialize

#### Desember 2026 (1 bulan) + 2027

**Desember — Polish**

- Rapikan semua dokumentasi
- Semua proyek ada di GitHub dengan README yang bagus
- Blog post minimal 8 artikel teknis
- Update CV dan LinkedIn dengan output nyata

**2027 — Pilih spesialisasi:** Setelah fondasi kuat, lu bisa pilih:

|Arah|Kalau lu suka|
|---|---|
|**SRE (Site Reliability)**|Observability, uptime, Kubernetes|
|**DevSecOps**|Security + automation pipeline|
|**Platform Engineer**|Internal tools, developer experience|
|**Cloud Architect**|Design sistem skala besar|

---

## Jadwal Harian — Non-Negotiable

```
WEEKDAY
───────────────────────────────
06:30 – 07:00  Baca konsep (teori, docs)
07:00 – 07:30  Praktek langsung di lab

20:30 – 21:30  Hands-on lab (rusak sesuatu, fix sesuatu)
21:30 – 22:00  Tulis di Obsidian (nanti jadi blog post)

WEEKEND
───────────────────────────────
Sabtu
09:00 – 11:00  Proyek mingguan (build something bigger)
11:00 – 12:00  Tulis & publish blog post

Minggu
09:00 – 10:00  Review minggu ini — apa yang belum paham?
10:00 – 10:30  Planning minggu depan
```

Total: **~10 jam/minggu.** Itu cukup kalau konsisten dan fokus.

---

## Aturan Keras yang Harus Lu Pegang

**1. Satu topik selesai dulu, baru lanjut** Nggak ada loncat-loncat. Kalau Bash scripting belum bisa bikin script fungsional, jangan mulai Docker.

**2. Homelab adalah sumber kebenaran** Setiap konsep harus pernah lu praktekkan di Proxmox lu. Kalau belum praktek, belum belajar.

**3. Tulis atau belum selesai** Setiap topik besar harus jadi minimal satu blog post. Ini paksa lu benar-benar paham.

**4. Error adalah progress** Kalau lu nggak pernah error, lu nggak belajar cukup dalam. Sengaja break sesuatu tiap minggu.

**5. Ukur output, bukan jam** Bukan "gue belajar 2 jam hari ini." Tapi "gue berhasil bikin X bekerja hari ini."

---

## Resource Per Phase

|Topik|Resource|Biaya|
|---|---|---|
|Linux|**The Linux Command Line** (William Shotts)|Gratis online|
|Linux|**linuxjourney.com**|Gratis|
|Bash|**bash scripting guide** (tldp.org)|Gratis|
|Docker|**TechWorld with Nana** (YouTube)|Gratis|
|Ansible|**Jeff Geerling** — YouTube + buku|Gratis/murah|
|Terraform|**HashiCorp Learn** (developer.hashicorp.com)|Gratis|
|Git|**Pro Git Book** (git-scm.com)|Gratis|
|AWS|**Stephane Maarek** di Udemy|~$15 saat sale|
|AWS Cert|**ExamTopics** practice questions|Gratis|

**Hampir semua gratis.** Modal lu adalah waktu dan konsistensi, bukan uang.

---

## Satu Hal Terakhir

Di akhir 2026, lu nggak akan jadi expert. **Dan itu bagus.**

Yang lu punya adalah:

- Fondasi yang benar-benar solid
- Portfolio yang bisa dibuktikan
- Arah yang jelas untuk 2027

Expert datang dari **2–3 tahun setelah fondasi itu terbentuk.**

Yang penting sekarang: **mulai hari ini, bukan Senin depan.**

---

Mulai dari mana hari ini? Gue rekomendasikan: **buka terminal, buat fresh Debian VM di Proxmox lu, dan setup dari nol.** Itu langkah pertama Phase 0.