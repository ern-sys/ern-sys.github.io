Dua opsi itu valid, tapi ada cara yang lebih efisien. Gini logikanya:

---

## Jangan Baca PDF Mentah-Mentah

Lo udah punya roadmap yang bilang _"Sesi 1: baca TLCL Bab 10 + LBH Bab 6."_ Kalau lo buka PDF-nya langsung dan baca dari awal bab itu — lo bakal overwhelmed lagi. Bab itu isinya banyak, dan lo gak tahu bagian mana yang penting buat target sesi lo.

---

## Workflow yang Lebih Efisien

Tiap mau mulai sesi, **balik ke NotebookLM** dan kasih prompt spesifik ini:

```
Saya akan memulai Sesi [nomor] tentang [topik].
Target saya: [salin target konkret dari roadmap].

Tolong buatkan:
1. Ringkasan konsep kunci yang perlu saya pahami (max 5 poin)
2. Perintah/syntax yang wajib saya hafal dan coba
3. Satu latihan praktis yang bisa saya kerjakan di terminal (45 menit)
4. Cara saya tahu bahwa saya sudah berhasil menguasai sesi ini
```

NotebookLM akan **menyaring bab yang relevan** dari buku lo dan menyajikan hanya yang lo butuhkan — bukan dump seluruh bab.

---

## Kapan Buka PDF Langsung?

Hanya dalam dua kondisi:

- NotebookLM ngasih konsep yang **masih blur** → buka bab referensinya, cari paragraf spesifiknya saja
- Lo mau **deep dive** setelah sesi selesai dan penasaran lebih jauh

---

## Jadi Alurnya:

```
Obsidian (cek sesi hari ini)
        ↓
NotebookLM (minta breakdown sesi)
        ↓
Terminal/Proxmox (praktek langsung)
        ↓
Obsidian (catat hasil + parking lot)
        ↓
PDF (opsional, kalau ada yang blur)
```

Simpel, gak buang energi buat milih-milih materi.

Mau gue buatin template prompt NotebookLM per sesi yang tinggal lo isi variabelnya aja tiap hari?