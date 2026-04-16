VLAN 10 = Dosen
VLAN 11 = Staff
VLAN 12 = Mhs
VLAN 13 = Gd A

Mangle Rule Forward > In. Interface (V10 - Dosen)
![[Pasted image 20260415115201.png]]

Tab Action > Mark Packet > New Packet Mark > (V10 - Upload Dosen)
![[Pasted image 20260415115253.png]]

## Ikuti aturan di atas untuk Pkt Download dan VLAN lainnya.

Queue Types:
> New Type
> Pilih pcq
> Masukan Rate untuk Koneksi (misalkan 20M)
> Masukan Burst Misalkan 25M
> Classier :
> 	Dst. Address = Downloads
> 	Src. Address = Uploads


