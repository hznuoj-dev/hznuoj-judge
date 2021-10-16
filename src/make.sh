#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

cd "${TOP_DIR}/judged" || exit 1

make
chmod +x judged
cp judged /usr/bin

cd "${TOP_DIR}/judge_client" || exit 1

make
chmod +x judge_client
cp judge_client /usr/bin

cd "${TOP_DIR}/sim/sim_2_77" || exit 1

make fresh
make exes
chmod +x sim*
cp sim_c.exe /usr/bin/sim_c
cp sim_java.exe /usr/bin/sim_java
cp sim_pasc.exe /usr/bin/sim_pas
cp sim_text.exe /usr/bin/sim_text
cp sim_lisp.exe /usr/bin/sim_scm

cd "${TOP_DIR}/sim" || exit 1

cp sim.sh /usr/bin
chmod +x /usr/bin/sim.sh
rm /usr/bin/sim_cc /usr/bin/sim_rb /usr/bin/sim_sh
ln -s /usr/bin/sim_c /usr/bin/sim_cc
