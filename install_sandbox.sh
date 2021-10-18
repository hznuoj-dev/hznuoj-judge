#! /bin/bash

set -ex

# shellcheck disable=SC2034
TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# Install dependencies
apt-get clean
apt-get update
apt-get dist-upgrade -y
apt-get install -y gnupg ca-certificates wget

# Key: Ubuntu Toolchain test repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 1e9377a2ba9ef27f
# Key: LLVM repo
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
# Key: Python repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BA6932366A755776
# Key: Go repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F6BC817356A3D45E
# Key: PHP repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4F4EA0AAE5267A6C
# Key: Haskell repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys FF3AEACEF6F88286
# Key: Mono repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# Add sources
echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main" > /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-focal.list
echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" > /etc/apt/sources.list.d/llvm.list
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main" > /etc/apt/sources.list.d/python.list
echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main" >  /etc/apt/sources.list.d/go.list
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/php.list
echo "deb http://ppa.launchpad.net/hvr/ghc/ubuntu focal main" > /etc/apt/sources.list.d/haskell.list
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" > /etc/apt/sources.list.d/mono.list

apt-get update

deps="make libmysql++-dev g++-11-multilib gcc-11-multilib clang-11 libc++-11-dev libc++abi-11-dev openjdk-11-jdk fpc python2.7 python3.9 golang-go php-cli ghc mono-devel fsharp ruby-full lua5.3"

for pkg in ${deps}
do
  install_ok='n'

  for i in $(seq 10)
  do
    if ! apt-get install -y "${pkg}"; then
      echo "Network error, install ${pkg} failure, number of retries: ${i}"
    else
      install_ok='y'
      break
    fi
  done

  if [[ "${install_ok}" = 'n' ]]; then
    echo "install ${pkg} failure"
    exit 1
  fi
done

ln -s /usr/bin/g++-11 /usr/local/bin/g++
ln -s /usr/bin/gcc-11 /usr/local/bin/gcc
ln -s /usr/bin/clang-11 /usr/local/bin/clang
ln -s /usr/bin/clang++-11 /usr/local/bin/clang++

# Clean the APT cache
apt-get clean
