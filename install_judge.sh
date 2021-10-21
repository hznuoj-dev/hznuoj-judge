#! /bin/bash

set -ex

INSTALL_JUDGE_SH_TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

apt-get install -y net-tools gawk dos2unix
apt-get clean

# compile and install the core
cd "${INSTALL_JUDGE_SH_TOP_DIR}/src" || exit 1
bash build.sh

cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/judged /usr/bin
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judge_client/judge_client /usr/bin
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_2_77/sim_c.exe /usr/bin/sim_c
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_2_77/sim_java.exe /usr/bin/sim_java
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_2_77/sim_pasc.exe /usr/bin/sim_pas
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_2_77/sim_text.exe /usr/bin/sim_text
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim_2_77/sim_lisp.exe /usr/bin/sim_scm
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/sim/sim.sh /usr/bin
chmod +x /usr/bin/sim.sh

for sim_x in /usr/bin/sim_cc /usr/bin/sim_rb /usr/bin/sim_sh; do
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

cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/java0.policy /home/judge/etc
cp "${INSTALL_JUDGE_SH_TOP_DIR}"/src/judged/judge.conf /home/judge/etc

chown -R judge /home/judge
chgrp -R root /home/judge/etc /home/judge/run?
chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run?

cp "${INSTALL_JUDGE_SH_TOP_DIR}/src/judged/judged.sh" /etc/init.d/judged
chmod +x /etc/init.d/judged
ln -s /etc/init.d/judged /etc/rc3.d/S93judged
ln -s /etc/init.d/judged /etc/rc2.d/S93judged
