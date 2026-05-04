#!/usr/bin/env bash
set -e

CUDA_HOME="$HOME/libs/cuda-13.2"
LIBTORCH_DIR="$HOME/libs/libtorch"

export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"

unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS
unset LDFLAGS

export PATH="/usr/bin:/bin:$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LIBTORCH_DIR/lib:$LD_LIBRARY_PATH"

rm -rf build
mkdir -p build
cd build

/usr/bin/cmake \
  -DCMAKE_PREFIX_PATH="$LIBTORCH_DIR" \
  -DCUDA_TOOLKIT_ROOT_DIR="$CUDA_HOME" \
  -DCUDAToolkit_ROOT="$CUDA_HOME" \
  ..

make -j

./example