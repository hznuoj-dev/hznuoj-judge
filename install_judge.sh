#! /bin/bash

set -ex

INSTALL_JUDGE_SH_TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# for sim
apt-get install -y flex
apt-get install -y net-tools gawk dos2unix
apt-get clean

# compile and install the core
cd "${INSTALL_JUDGE_SH_TOP_DIR}/src" || exit 1
bash build.sh

SIM_VERSION=3_0_2
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/judged /usr/bin
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judge_client/judge_client /usr/bin
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_c.exe /usr/bin/sim_c
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_c++.exe /usr/bin/sim_cc
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_java.exe /usr/bin/sim_java
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_pasc.exe /usr/bin/sim_pas
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_text.exe /usr/bin/sim_text
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_${SIM_VERSION}/sim_lisp.exe /usr/bin/sim_scm
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim.sh /usr/bin
chmod +x /usr/bin/sim.sh

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
mkdir -p /home/judge/run4
mkdir -p /home/judge/run5
mkdir -p /home/judge/run6
mkdir -p /home/judge/run7

cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/java0.policy /home/judge/etc
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/judge.conf /home/judge/etc

chown -R judge /home/judge
chgrp -R root /home/judge/etc /home/judge/run?
chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run?

cp "${INSTALL_JUDGE_SH_TOP_DIR}/src/judged/judged.sh" /etc/init.d/judged
chmod +x /etc/init.d/judged
ln -s /etc/init.d/judged /etc/rc3.d/S93judged
ln -s /etc/init.d/judged /etc/rc2.d/S93judged
