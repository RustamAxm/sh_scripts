# lan app 
Script for run shared dhcp internet connection 
1. install dhcp server
```
sudo apt install isc-dhcp-server
```
2. Run script <inet_port> to <share_dhcp_port>
```
:~/sh_scripts/lan_app$ ./lan_app_mode wlp0s20f3 enp0s31f6 enable
+ wwan_nic=wlp0s20f3
+ lan_nic=enp0s31f6
+ action=enable
+ net_base=192.168.1
+ sudo iptables --flush
+ sudo ip a f enp0s31f6
+ nmcli device show wlp0s20f3
+ grep DNS
+ grep -E -o ([0-9]{1,3}\.){3}[0-9]{1,3}
+ var=192.168.50.1
+ echo DNS from wifi  192.168.50.1
DNS from wifi  192.168.50.1
+ sudo echo ddns-update-style none;

authoritative;

subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.180;
  option domain-name-servers 192.168.50.1;
  option subnet-mask 255.255.255.0;
  option routers 192.168.1.1;
  option broadcast-address 192.168.1.255;
  default-lease-time 6000;
  max-lease-time 7200;
}
+ echo config writed
config writed
+ sudo cp new_dhcp_conf.conf /etc/dhcp/dhcpd.conf
+ sudo ip l s enp0s31f6 up
+ sudo ip a a 192.168.1.1/24 dev enp0s31f6 brd +
+ sudo iptables -A FORWARD -o wlp0s20f3 -i enp0s31f6 -s 192.168.1.0/24 -m conntrack --ctstate NEW -j ACCEPT
+ sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
+ sudo iptables -t nat -F POSTROUTING
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

3. For disable just run 
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
