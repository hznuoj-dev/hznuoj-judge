#! /bin/bash

set -ex

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# Install dependencies
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

# Add sources
echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main" > /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-focal.list
echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" > /etc/apt/sources.list.d/llvm.list
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main" > /etc/apt/sources.list.d/python.list
echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main" >  /etc/apt/sources.list.d/go.list
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/php.list

apt-get update

deps="make libmysql++-dev g++-11-multilib gcc-11-multilib clang-11 libc++-11-dev libc++abi-11-dev openjdk-11-jdk fpc python2.7 python3.9 golang-go php8.1-cli"

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

# compile and install the core
cd "${TOP_DIR}/src" || exit 1
bash build.sh

cp "${TOP_DIR}"/src/judged/judged /usr/bin
cp "${TOP_DIR}"/src/judge_client/judge_client /usr/bin
cp "${TOP_DIR}"/src/sim/sim_2_77/sim_c.exe /usr/bin/sim_c
cp "${TOP_DIR}"/src/sim/sim_2_77/sim_java.exe /usr/bin/sim_java
cp "${TOP_DIR}"/src/sim/sim_2_77/sim_pasc.exe /usr/bin/sim_pas
cp "${TOP_DIR}"/src/sim/sim_2_77/sim_text.exe /usr/bin/sim_text
cp "${TOP_DIR}"/src/sim/sim_2_77/sim_lisp.exe /usr/bin/sim_scm
cp "${TOP_DIR}"/src/sim/sim.sh /usr/bin
chmod +x /usr/bin/sim.sh

for sim_x in /usr/bin/sim_cc /usr/bin/sim_rb /usr/bin/sim_sh
do
  if [[ -x "${sim_x}" ]]; then
    rm "${sim_x}"
  fi
done

ln -s /usr/bin/sim_c /usr/bin/sim_cc

# create user and homedir
/usr/sbin/useradd -m -u 1536 judge

# create work dir set default conf
mkdir -p /home/judge
mkdir -p /home/judge/etc
mkdir -p /home/judge/data
mkdir -p /home/judge/log
mkdir -p /home/judge/run0
mkdir -p /home/judge/run1
mkdir -p /home/judge/run2
mkdir -p /home/judge/run3

cp "${TOP_DIR}"/src/judged/java0.policy /home/judge/etc
cp "${TOP_DIR}"/src/judged/judge.conf /home/judge/etc

chown -R judge /home/judge
chgrp -R root /home/judge/etc /home/judge/run?
chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run?

cp "${TOP_DIR}/src/judged/judged.sh" /etc/init.d/judged
chmod +x  /etc/init.d/judged
ln -s /etc/init.d/judged /etc/rc3.d/S93judged
ln -s /etc/init.d/judged /etc/rc2.d/S93judged
