#!/bin/bash
set -exo pipefail

# Install to conda style directories
if [[ -d lib/12 ]]; then
    mv lib/12/* lib/
    rmdir lib/12
fi
if [[ -d lib/13 ]]; then
    mv lib/13/* lib/
    rmdir lib/13
fi

mkdir -p ${PREFIX}/lib
if [[ -d pkg-config ]]; then
    mv pkg-config ${PREFIX}/lib/pkgconfig
fi
# Guard on the files, not the directory: the host env can provide lib/pkgconfig
# without any nvtiff*.pc (the archive ships none), and sed would fail on the bare glob.
for pc in "$PREFIX"/lib/pkgconfig/nvtiff*.pc; do
    [[ -f $pc ]] || continue
    sed -E -i "s|cudaroot=.+|cudaroot=$PREFIX|g" "$pc"
done

for i in `ls`; do
    if [[ $i == "build_env_setup.sh" || $i == "conda_build.sh" || $i == "metadata_conda_debug.yaml" ]]; then
        continue
    fi
    cp -rv $i ${PREFIX}
done

check-glibc $PREFIX/lib/*.so.*
