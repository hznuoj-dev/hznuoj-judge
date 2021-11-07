# hznuoj-judge

[![Build Compiler](https://github.com/hznuoj-dev/hznuoj-judge/actions/workflows/build_compiler.yml/badge.svg)](https://github.com/hznuoj-dev/hznuoj-judge/actions/workflows/build_compiler.yml)
[![Build Judge](https://github.com/hznuoj-dev/hznuoj-judge/actions/workflows/build_judge.yml/badge.svg)](https://github.com/hznuoj-dev/hznuoj-judge/actions/workflows/build_judge.yml)

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
docker build -t hznuoj-compiler:latest -f docker/Dockerfile.compiler ./
docker build -t hznuoj-judge:latest -f docker/Dockerfile.judge ./
```

### Start

```bash
docker run -it --privileged=true --cap-add=SYS_PTRACE --shm-size="2g" --restart=always -d \
--name=hznuoj-judge \
-v /var/hznuoj-judge/judge.conf:/home/judge/etc/judge.conf \
-v /var/hznuoj-judge/data:/home/judge/data \
hznuoj-judge:latest
```

### Exec

```bash
docker exec -it hznuoj-judge bash
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
