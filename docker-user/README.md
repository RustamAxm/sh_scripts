# user docker 
```
rustam@rustam-zenbook:~/sh_scripts/docker-user$ docker build -t test-user-docker .
```
test permission
```
rustam@rustam-zenbook:~/sh_scripts/docker-user$ docker run -it --rm -v $(pwd):/workdir test-user-docker:latest bash 
user-name@553053ae5589:/workdir$ ls
Dockerfile
user-name@553053ae5589:/workdir$ mkdir testdir
user-name@553053ae5589:/workdir$ ll
total 28
drwxrwxr-x 3 user-name user-name  4096 Apr  6 11:03 ./
drwxr-xr-x 1 root      root       4096 Apr  6 11:03 ../
-rw------- 1 user-name user-name 12288 Apr  6 11:01 .README.md.swp
-rw-rw-r-- 1 user-name user-name   830 Apr  6 11:00 Dockerfile
drwxr-xr-x 2 user-name user-name  4096 Apr  6 11:03 testdir/
user-name@553053ae5589:/workdir$ exit
exit
rustam@rustam-zenbook:~/sh_scripts/docker-user$ rm testdir/
rm: cannot remove 'testdir/': Is a directory
rustam@rustam-zenbook:~/sh_scripts/docker-user$ rm -fr testdir/
rustam@rustam-zenbook:~/sh_scripts/docker-user$ ll
total 24
drwxrwxr-x  2 rustam rustam  4096 Apr  6 14:03 ./
drwxrwxr-x 10 rustam rustam  4096 Apr  6 13:57 ../
-rw-rw-r--  1 rustam rustam   830 Apr  6 14:00 Dockerfile
-rw-------  1 rustam rustam 12288 Apr  6 14:01 .README.md.swp
```
