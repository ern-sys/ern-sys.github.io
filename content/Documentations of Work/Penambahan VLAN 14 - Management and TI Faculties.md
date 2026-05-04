![[Pasted image 20260504141651.png]]

Add VLAN dengan ID 14. untuk Manajemen dan Prodi TI. 

![[Pasted image 20260504141858.png]]

Add addresses > untuk segment VLAN 14 diberikan subnet dengan IP 192.168.40.1/25

![[Pasted image 20260504141941.png]]

Berikan 3 Port dalam Cisco Catalyst 1200 untuk assign VLAN di Ports 39-41 untuk Access VLAN 14. `switchport mode access` > `switchport access vlan 14`

- Note: **Trunking sudah dilakukan di Port 52 menggunakan SFP+2. `switchport mode trunk`**
 
Assign DHCP Server di Router MikroTik. 
![[Pasted image 20260504142217.png]]

![[Pasted image 20260504142255.png]]

masuk ke Address.List untuk penambahan IP dari VLAN  baru yakni VLAN 14.

Selesai. Awokawokawok
