# lan app 
Script for run shared dhcp internet connection 
1. First off all edit /etc/dhcp/dhcpd.conf  
```
sudo nano /etc/dhcp/dhcpd.conf
```
[example my setup](dhcpd.conf)  
2. Run script <inet_port> to <share_dhcp_port>
```
:~/sh_scripts/lan_app$ ./lan_app_mode wlp0s20f3 enp0s31f6 enable
+ wwan_nic=wlp0s20f3
+ lan_nic=enp0s31f6
+ action=enable
+ net_base=192.168.1
+ sudo iptables --flush
[sudo] password for rustam: 
+ sudo ip a f enp0s31f6
+ sudo sysctl -w net.ipv4.ip_forward=1
net.ipv4.ip_forward = 1
+ sudo ip l s enp0s31f6 up
+ sudo ip a a 192.168.1.1/24 dev enp0s31f6 brd +
+ sudo iptables -t nat -A POSTROUTING -o wlp0s20f3 -j MASQUERADE
+ sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j MASQUERADE
+ sudo sysctl -w net.ipv4.ip_forward=1
net.ipv4.ip_forward = 1
+ sudo systemctl restart isc-dhcp-server.service
```
for check status:
```
:~/sh_scripts/lan_app$ systemctl status isc-dhcp-server
● isc-dhcp-server.service - ISC DHCP IPv4 server
     Loaded: loaded (/lib/systemd/system/isc-dhcp-server.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-02-18 21:24:37 MSK; 25s ago
       Docs: man:dhcpd(8)
   Main PID: 9274 (dhcpd)
      Tasks: 4 (limit: 18730)
     Memory: 4.4M
     CGroup: /system.slice/isc-dhcp-server.service
             └─9274 dhcpd -user dhcpd -group dhcpd -f -4 -pf /run/dhcp-server/dhcpd.pid -cf /etc/dhcp/dhcpd.conf enp0s31f6

фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: PID file: /run/dhcp-server/dhcpd.pid
фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: Wrote 7 leases to leases file.
фев 18 21:24:37 nb-ubuntu-02 sh[9274]: Wrote 7 leases to leases file.
фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: Listening on LPF/enp0s31f6/f4:a8:0d:4b:0d:2a/192.168.1.0/24
фев 18 21:24:37 nb-ubuntu-02 sh[9274]: Listening on LPF/enp0s31f6/f4:a8:0d:4b:0d:2a/192.168.1.0/24
фев 18 21:24:37 nb-ubuntu-02 sh[9274]: Sending on   LPF/enp0s31f6/f4:a8:0d:4b:0d:2a/192.168.1.0/24
фев 18 21:24:37 nb-ubuntu-02 sh[9274]: Sending on   Socket/fallback/fallback-net
фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: Sending on   LPF/enp0s31f6/f4:a8:0d:4b:0d:2a/192.168.1.0/24
фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: Sending on   Socket/fallback/fallback-net
фев 18 21:24:37 nb-ubuntu-02 dhcpd[9274]: Server starting service.

```
3. Set client side interface config
```
:~ $ cat /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp
```
4. For disable just run 
```
:~/sh_scripts/lan_app$ ./lan_app_mode wlp0s20f3 enp0s31f6 disable
+ wwan_nic=wlp0s20f3
+ lan_nic=enp0s31f6
+ action=disable
+ net_base=192.168.1
+ sudo iptables --flush
+ sudo ip a f enp0s31f6
+ sudo ip l s enp0s31f6 down
+ sudo sysctl -w net.ipv4.ip_forward=0
net.ipv4.ip_forward = 0
```
