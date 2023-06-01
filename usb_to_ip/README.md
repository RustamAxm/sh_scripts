# usb to ip 

## Server rpi part
install 
```
sudo apt install usbip
```

set kernel module 
```
sudo modprobe usbip_host
echo 'usbip_host' >> /etc/modules
```
check usb devices
```
lsusb -tv
```
command to find out your device’s bus ID
```
usbip list -p -l
```
<details>
  <summary>commands </summary>
  ```
pi@raspberrypi:~ $ lsusb -tv
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 0424:2514 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
        |__ Port 1: Dev 3, If 0, Class=Hub, Driver=hub/3p, 480M
            ID 0424:2514 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
            |__ Port 1: Dev 4, If 0, Class=Vendor Specific Class, Driver=lan78xx, 480M
                ID 0424:7800 Microchip Technology, Inc. (formerly SMSC) 
        |__ Port 3: Dev 5, If 0, Class=Vendor Specific Class, Driver=, 12M
            ID 1a86:5512 QinHeng Electronics CH341 in EPP/MEM/I2C mode, EPP/I2C adapter
pi@raspberrypi:~ $ usbip list -p -l
busid=1-1.1.1#usbid=0424:7800#
busid=1-1.3#usbid=1a86:5512#
pi@raspberrypi:~ $ sudo usbip bind --busid=1-1.3
usbip: info: bind device on busid 1-1.3: complete

```
</details>

run share usb 
```
sudo usbipd
```
<details>
  <summary>sudo usbipd </summary>
```
pi@raspberrypi:~ $ sudo usbipd
usbipd: info: starting usbipd (usbip-utils 2.0)
usbipd: info: listening on 0.0.0.0:3240
usbipd: info: listening on :::3240

```
</details>

## Client ubuntu

install
```
sudo apt install linux-tools-5.19.0-42-generic
```

run client 
```
sudo usbip attach -r 10.77.47.49 -b 1-1.3
```
<details>
  <summary>lsusb -tv </summary>
  ```
rustam@nb-ubuntu-02:~/sh_scripts/docker_usb$ lsusb -tv
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=vhci_hcd/8p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=vhci_hcd/8p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=i2c-ch341-usb, 12M
        ID 1a86:5512 QinHeng Electronics CH341 in EPP/MEM/I2C mode, EPP/I2C adapter
```
</details>
