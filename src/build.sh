#! /bin/bash

BUILD_SH_TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
SIM_DIR="${BUILD_SH_TOP_DIR}/sim/sim_3_0_2"

cd "${BUILD_SH_TOP_DIR}/judged" || exit 1

make
chmod +x judged

cd "${BUILD_SH_TOP_DIR}/judge_client" || exit 1

make
chmod +x judge_client

cd "${SIM_DIR}" || exit 1

make fresh

if [[ -f "${SIM_DIR}/sim_gen.c" ]]; then
  rm "${SIM_DIR}/sim_gen.c"
fi

make exes

chmod +x sim_*.exe
