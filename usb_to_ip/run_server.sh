#!/bin/sh -ex

sudo usbip list -l -p
sudo modprobe usbip_host
sudo usbip bind --busid=1-1.3
sudo usbip bind --busid=1-1.1.2
sudo usbipd &
