# sh_scripts
Helpfull scripts for debian based os

# deb package 
structure
```
rustam@rustam-zenbook:~/sh_scripts$ mkdir my-package-deb
rustam@rustam-zenbook:~/sh_scripts$ mkdir -p my-package-deb/DEBIAN
rustam@rustam-zenbook:~/sh_scripts$ vim my-package-deb/DEBIAN/control
rustam@rustam-zenbook:~/sh_scripts$ vim my-package-deb/DEBIAN/postinst
rustam@rustam-zenbook:~/sh_scripts$ mkdir -p my-package-deb/usr/local/bin
rustam@rustam-zenbook:~/sh_scripts$ vim my-package-deb/usr/local/bin/my-package-deb
rustam@rustam-zenbook:~/sh_scripts$ vim my-package-deb/DEBIAN/control
rustam@rustam-zenbook:~/sh_scripts$ tree my-package-deb/
my-package-deb/
├── DEBIAN
│   ├── control
│   └── postinst
└── usr
    └── local
        └── bin
            └── my-package-deb

```
content for debian 
```
rustam@rustam-zenbook:~/sh_scripts$ cat my-package-deb/DEBIAN/control 
Package: my-package-deb
Version: 1.0.0
Section: unknown
Priority: optional
Depends: libzmq3-dev, python3-pip
Architecture: amd64
Essential: no
Installed-Size: 20
Maintainer: Akhmadullin Rustam <rustamaxm@gamil.com>
Description: Demo for cretae deb packages
rustam@rustam-zenbook:~/sh_scripts$ cat my-package-deb/DEBIAN/postinst 
#!/bin/bash 
echo "post install script demo"
```
script for run 
```
rustam@rustam-zenbook:~/sh_scripts$ cat my-package-deb/usr/local/bin/my-package-deb 
#!/bin/bash 
echo "demo string from package"
```
build package 
```
rustam@rustam-zenbook:~/sh_scripts$ dpkg-deb --build my-package-deb
dpkg-deb: building package 'my-package-deb' in 'my-package-deb.deb'.
rustam@rustam-zenbook:~/sh_scripts$ ll
total 44
drwxrwxr-x  9 rustam rustam 4096 Mar 19 20:04 ./
drwxr-x--- 51 rustam rustam 4096 Mar 19 20:03 ../
drwxrwxr-x  2 rustam rustam 4096 Mar 19 19:49 can_to_docker/
drwxrwxr-x  3 rustam rustam 4096 Mar 19 19:49 docker_usb/
drwxrwxr-x  8 rustam rustam 4096 Mar 19 19:49 .git/
drwxrwxr-x  2 rustam rustam 4096 Mar 19 19:49 lan_app/
drwxrwxr-x  4 rustam rustam 4096 Mar 19 19:57 my-package-deb/
-rw-r--r--  1 rustam rustam  740 Mar 19 20:04 my-package-deb.deb
-rw-rw-r--  1 rustam rustam 1288 Mar 19 20:03 README.md
drwxrwxr-x  2 rustam rustam 4096 Mar 19 19:49 route_ip_to_ip/
drwxrwxr-x  2 rustam rustam 4096 Mar 19 19:49 usb_to_ip/
```
install by apt for install deps and run 
```
rustam@rustam-zenbook:~/sh_scripts$ sudo apt install ./my-package-deb.deb 
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Note, selecting 'my-package-deb' instead of './my-package-deb.deb'
The following packages were automatically installed and are no longer required:
  libllvm17t64 python3-netifaces
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  my-package-deb
0 upgraded, 1 newly installed, 0 to remove and 18 not upgraded.
Need to get 0 B/736 B of archives.
After this operation, 20.5 kB of additional disk space will be used.
Get:1 /home/rustam/sh_scripts/my-package-deb.deb my-package-deb amd64 1.0.0 [736 B]
Selecting previously unselected package my-package-deb.
(Reading database ... 238087 files and directories currently installed.)
Preparing to unpack .../sh_scripts/my-package-deb.deb ...
Unpacking my-package-deb (1.0.0) ...
Setting up my-package-deb (1.0.0) ...
post install script demo
N: Download is performed unsandboxed as root as file '/home/rustam/sh_scripts/my-package-deb.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
rustam@rustam-zenbook:~/sh_scripts$ my-package-deb 
demo string from package

```
