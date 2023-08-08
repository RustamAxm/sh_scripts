# SocketCAN to Docker
Show can socket
<details>
  <summary> ip a

  ```bash
  15: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP group default qlen 10
    link/can 
  16: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP group default qlen 10
    link/can
  ```
</details>

build container with name can_to_docker
```bash
docker build -t can_to_docker .
```
run container in host network with name test_can1
```bash
docker run -it --rm --network host --name test_can1 can_to_docker
```
ip a in container
<details> 
  <summary> ip a

  ```bash
  root@Linux:/app# ip a
  15: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP group default qlen 10
    link/can 
  16: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP group default qlen 10
    link/can 
  ```
</details> 