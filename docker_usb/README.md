# USB to Docker
Util for running n servers in rpi util [virtualhere](https://www.virtualhere.com/usb_server_software)

## RPI part
### dhcp 
cool repo [docker-net-dhcp](https://github.com/devplayer0/docker-net-dhcp)

After run container 
```
docker run --rm -itd --network="my-dhcp-net" --privileged -v /dev/bus/usb:/dev/bus/usb --name vh_container_1  vh_image
```
docker network inspect
```
pi@raspberrypi:~ $ docker network inspect my-dhcp-net 
[
    {
        "Name": "my-dhcp-net",
        "Id": "61ae4c4e10c5fd99ee08da3556c54ba2c2d70e4f92f605cd486d36a2a61b4cdb",
        "Created": "2023-03-30T17:11:57.838628163+03:00",
        "Scope": "local",
        "Driver": "ghcr.io/devplayer0/docker-net-dhcp:release-linux-arm-v7",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "null",
            "Options": {},
            "Config": [
                {
                    "Subnet": "0.0.0.0/0"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "6562b17c1677ddb8627b8a88fe29baf5e92cd65d7535da8f581d679f341e7fd5": {
                "Name": "vh_container_1",
                "EndpointID": "6ec00bf73e6466dfc268bb99b66fbf76b4a76b18b324860e38b833c623a69fe8",
                "MacAddress": "e6:1f:2a:99:fb:c2",
                "IPv4Address": "192.168.1.149/24",
                "IPv6Address": ""
            },
            "7bdf1bc087c6b62c782dc0d357c2d8b5ea6218c6a5df2a21039de5a37f082633": {
                "Name": "vh_container_0",
                "EndpointID": "d5c582f8a97436e8f695221d38ad06a84528b1912cd740ebcfe3824c2d7e61b0",
                "MacAddress": "ba:be:b1:15:f7:90",
                "IPv4Address": "192.168.1.148/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "bridge": "my-bridge"
        },
        "Labels": {}
    }
]

```
dhcp server log
```
● isc-dhcp-server.service - ISC DHCP IPv4 server
     Loaded: loaded (/lib/systemd/system/isc-dhcp-server.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-03-30 16:49:07 MSK; 29min ago
       Docs: man:dhcpd(8)
   Main PID: 20993 (dhcpd)
      Tasks: 4 (limit: 18725)
     Memory: 4.5M
     CGroup: /system.slice/isc-dhcp-server.service
             └─20993 dhcpd -user dhcpd -group dhcpd -f -4 -pf /run/dhcp-server/dhcpd.pid -cf /etc/dhcp/dhcpd.conf enp0s31f6

мар 30 17:13:20 nb-ubuntu-02 dhcpd[20993]: DHCPACK on 192.168.1.147 to 26:9f:27:8c:af:a2 (03a039ecb8c8) via enp0s31f6
мар 30 17:15:55 nb-ubuntu-02 dhcpd[20993]: DHCPRELEASE of 192.168.1.147 from 26:9f:27:8c:af:a2 (03a039ecb8c8) via enp0s31f6 (found)
мар 30 17:18:31 nb-ubuntu-02 dhcpd[20993]: DHCPDISCOVER from ba:be:b1:15:f7:90 via enp0s31f6
мар 30 17:18:32 nb-ubuntu-02 dhcpd[20993]: DHCPOFFER on 192.168.1.148 to ba:be:b1:15:f7:90 via enp0s31f6
мар 30 17:18:32 nb-ubuntu-02 dhcpd[20993]: DHCPREQUEST for 192.168.1.148 (192.168.1.1) from ba:be:b1:15:f7:90 via enp0s31f6
мар 30 17:18:32 nb-ubuntu-02 dhcpd[20993]: DHCPACK on 192.168.1.148 to ba:be:b1:15:f7:90 via enp0s31f6
мар 30 17:18:34 nb-ubuntu-02 dhcpd[20993]: DHCPDISCOVER from ba:be:b1:15:f7:90 via enp0s31f6
мар 30 17:18:34 nb-ubuntu-02 dhcpd[20993]: DHCPOFFER on 192.168.1.148 to ba:be:b1:15:f7:90 (7bdf1bc087c6) via enp0s31f6
мар 30 17:18:34 nb-ubuntu-02 dhcpd[20993]: DHCPREQUEST for 192.168.1.148 (192.168.1.1) from ba:be:b1:15:f7:90 (7bdf1bc087c6) via enp0s31f6
мар 30 17:18:34 nb-ubuntu-02 dhcpd[20993]: DHCPACK on 192.168.1.148 to ba:be:b1:15:f7:90 (7bdf1bc087c6) via enp0s31f6

```
### Macvlan if set ip
Setup --network="demo-macvlan" 
```
docker network create -d macvlan \
    --subnet=192.168.1.0/24 \
    --gateway=192.168.1.1  \
    -o parent=eth0 \
     demo-macvlan
```

cd folder docker_usb
```
docker build -t vh_image . 
```
after building just run daemon -itd
```
docker run --rm -itd --network="demo-macvlan" --ip=192.168.1.110 --privileged -v /dev/bus/usb:/dev/bus/usb --name vh_container vh_image
```

after run servers go to client

## Client part 
```
sudo ./vhuit64
```
start window

![Alt text](images/start_win.png?raw=true "Optional Title")

main window

![Alt text](images/main_win.png?raw=true "Optional Title")

## Docker explaining
for interactive log usage flaf -it 
```
docker run --rm -it --network="demo-macvlan" --ip=192.168.1.110 --privileged -v /dev/bus/usb:/dev/bus/usb --name vh_container vh_image
```
### For forwarding file to container add flag

```
--privileged -v /dev/bus/usb:/dev/bus/usb
```


### Docker container network access

link https://docs.docker.com/config/containers/container-networking/
```
--network="bridge"
```
example 

```
docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb --network="bridge" --name vh_container vh_image bash
```

### Network connection to Docker container
link https://www.linuxtechi.com/create-use-macvlan-network-in-docker/  https://docs.docker.com/network/network-tutorial-macvlan/
```
--network="demo-macvlan" --ip=<set ip>
```
example 
```
docker run --rm -it --network="demo-macvlan" --ip=192.168.1.111 --privileged -v /dev/bus/usb:/dev/bus/usb --name vh_container vh_image bash
```


