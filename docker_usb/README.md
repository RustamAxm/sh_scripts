# USB to Docker
Util for running n servers in rpi util https://www.virtualhere.com/usb_server_software
## RPI part
cd folder docker_usb
```
docker build -t vh_image . 
```
after building just run deamon -itd
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


