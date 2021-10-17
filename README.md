# hznuoj-judge


## Use Docker
### Build

```bash
docker build -t hznuoj-judge:latest -f docker/Dockerfile ./
```

### Start

```bash
docker run -it -d \
--name=hznuoj-judge \
-v /var/hznuoj-judge/judge.conf:/home/judge/etc/judge.conf \
-v /var/hznuoj-judge/data:/home/judge/data \
hznuoj-judge:latest
```

## Use sshfs

You may need `sshfs` to remotely mount some data folders.

First need to install it:

```bash
sudo apt-get install sshfs fuse
```

mount remote folder:

```bash
sudo sshfs -o allow_other,IdentityFile=~/.ssh/id_rsa root@x.x.x.x:/home/judge/data /var/hznuoj-judge/data
```

If you want to mount at boot:

Append the following line to `/etc/fstab`

```plain
sshfs#root@172.22.237.2:/home/judge/data /var/hznuoj-judge/data fuse delay_connect,workaround=rename,idmap=user,allow_other,IdentityFile=~/.ssh/id_rsa 0 0
```

And execute `sudo mount -a` to make it effective.

It should be noted that before adding this line of content, you need to manually execute `sshfs` mount.

You can check the mount status with the following command

```bash
df -hT
```

Like below:

<p align="center">

<img src="./screenshots/df -hT.png" />

</p>

If you want to unmount, you can use the following command:

```bash
sudo umount /var/hznuoj-judge/data
```
