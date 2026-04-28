Linux Bible:

gue belajar bagaimana permission dalam Linux dengan menggunakan chmod + chown. dengan struktur seperti ini:  
  

`useradd -m enggar'

`sudo passwd enggar`

`mkdir -p top-secret`

`chmod 740 top-secret` ( 4 Write, 2 Read, 1 Exec) = 7 angka awal sebagai kepemilikan user, angka kedua yakni 4 adalah kepemilikan Group, dan angka 0 di belakang kepemilikan untuk Others.

`sudo usermod -aG sudo enggar`

`sudo newgrp enggar`

`sudo groupadd IT`

sudo chown enggar:IT top-secret` = dari folder/directory top-secret berarti menjadikan enggar sebagai pemilik folder, dan dengan group IT.

  

`sudo useradd -m hasan`

`sudo passwd hasan`

`sudo usermod -aG IT hasan`

`sudo useradd -m wira`

`sudo passwd wira`

`sudo usermod -aG IT wira`

  

`sudo apt install acl -y`

`sudo setfacl -m u:wira:rx top-secret` = kasus setfacl -m adalah parameter dimana -m agar tidak mengubah settingan / configuration awal.

  

`sudo setfacl -m u:hasan:rx top-secret`

  

dengan perintah diatas adalah menjadikan wira dan hasan di folder top-secret sebagai user yang hanya bisa melihat dan masuk folder saja. dengan seperti itu, permission dari file/folder didalam sebuah server tidak akan di jadikan semua akses bagi hacker nantinya. ini disebut juga sebagai security hardening.