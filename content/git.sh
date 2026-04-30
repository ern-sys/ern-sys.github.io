#!/bin/bash
git add .
git commit -m "read -p 'Keterangan Publish ke GitHub: ?' Ket "
echo "Oke, di Proses dengan Keterangan: $Ket"
git push origin main
