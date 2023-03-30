#!/bin/sh -ex

action=${1:-up}
lan_nic=${2:-eth0}
name=${3:-my-bridge}


case "$action" in
up)
    # Create the bridge
    sudo ip link add my-bridge type bridge
    sudo ip link set my-bridge up

    # Assuming 'eth0' is connected to your LAN (where the DHCP server is)
    sudo ip link set $lan_nic up
    # Attach your network card to the bridge
    sudo ip link set $lan_nic master $name

    # If your firewall's policy for forwarding is to drop packets, you'll need to add an ACCEPT rule
    sudo iptables -A FORWARD -i $name -j ACCEPT

    # Get an IP for the host (will go out to the DHCP server since eth0 is attached to the bridge)
    # Replace this step with whatever network configuration you were using for eth0
    sudo dhcpcd $name
    ;;
down)
    sudo iptables -D FORWARD -i $name -j ACCEPT
    sudo ip link delete $name type bridge
    ;;
esac
