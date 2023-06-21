#!/bin/sh -ex

# EXTIP = external IP of gateway (1.2.3.4)
# EPORT = external port (12345)
# DIP   = destination IP in local network (192.168.2.10)
# DPORT = destination port (54321)
# INTIP = internal IP of gateway (192.168.2.5)
DIP=192.168.1.158
DPORT=5555
EXTIP=10.77.47.105
EPORT=5555
INTIP=192.168.1.1

sysctl -w net.ipv4.ip_forward=1

ip a a "${INTIP}/24" dev eth0
 
iptables -A FORWARD -p tcp -d $DIP --dport $DPORT -j ACCEPT
iptables -A FORWARD -p tcp -s $DIP --sport $DPORT -j ACCEPT

iptables -A PREROUTING -t nat -p tcp -d $EXTIP --dport $EPORT -j DNAT --to-destination $DIP:$DPORT
iptables -A POSTROUTING -t nat -p tcp -d $DIP --dport $DPORT -j SNAT --to-source $INTIP
