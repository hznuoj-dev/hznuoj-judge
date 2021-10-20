# hznuoj-judge

It's based on Ubuntu 20.04 and contains compilers (and interpreters) below:

* GCC 11 (from [PPA](https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test))
* Clang 11 (from [LLVM](https://apt.llvm.org/))
* OpenJDK 11
* Free Pascal 3
* Python 2.7 (from [PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa))
* Python 3.9 (from [PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa))
* Go (from [PPA](https://launchpad.net/~longsleep/+archive/ubuntu/golang-backports))
* PHP 8.1 (from [PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php))
* GHC (from [PPA](https://launchpad.net/~hvr/+archive/ubuntu/ghc))
* C# (from [Mono](https://www.mono-project.com/download/stable/))
* F# (from [Mono](https://www.mono-project.com/download/stable/))
* Bash
* Perl
* Ruby
* Lua 5.3

Each compiler (or interpreter) is available in `$PATH`.

## Use Docker
### Build

Direct build:

```bash
docker build -t hznuoj-judge:latest -f docker/Dockerfile ./
```

Step-by-step build:

```bash
docker build -t hznuoj-sandbox:latest -f docker/Dockerfile.sandbox ./
docker build -t hznuoj-judge:latest -f docker/Dockerfile.judge ./
```

### Start

```bash
docker run -it --privileged=true --cap-add=SYS_PTRACE --net=host -d \
--name=hznuoj-judge \
-v /var/hznuoj-judge/judge.conf:/home/judge/etc/judge.conf \
-v /var/hznuoj-judge/data:/home/judge/data \
hznuoj-judge:latest
```

### Exec

```bash
docker exec -it hznuoj-judge bash
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

## Debug

### Judge

```bash
judged /home/judge debug
```

### Judge Client

```bash
judge_client <solution_id> <run dir id> [oj_home_dir] [debug]
```

