#! /bin/bash

BUILD_SH_TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

cd "${BUILD_SH_TOP_DIR}/judged" || exit 1

make
chmod +x judged

cd "${BUILD_SH_TOP_DIR}/judge_client" || exit 1

make
chmod +x judge_client

cd "${BUILD_SH_TOP_DIR}/sim/sim_2_77" || exit 1

rm ./*.o
rm ./*.exe

make exes

chmod +x sim_*.exe
