#!/bin/sh -ex

action=${1:-attach}
ip=${2:-10.77.46.175}

case "$action" in
attach)

sudo modprobe vhci-hcd
sudo modprobe usbip_host
sudo usbip list -p -r $ip
#sudo usbip attach -r $ip -b 1-1.3
sudo usbip attach -r $ip -b 1-8
sudo usbip port
;;
detach)
sudo usbip port
port=$(sudo usbip port | grep Port | grep -E -o "[0-9][0-9]") 
sudo usbip detach -p $port
;;
esac
