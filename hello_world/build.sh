#!/usr/bin/env bash
set -e

# Paths
CONDA_ENV="$HOME/miniconda3/envs/iee577"
CUDA_TARGET="$CONDA_ENV/targets/x86_64-linux"
LIBTORCH_DIR="$HOME/libs/libtorch"

# Use system compiler/linker, not conda compiler/linker
export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"

# Runtime library paths
export LD_LIBRARY_PATH="$CUDA_TARGET/lib:$LIBTORCH_DIR/lib:$LD_LIBRARY_PATH"

# Clean environment variables that conda may inject into compilation
unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS
unset LDFLAGS

# Keep system tools first, but keep conda nvcc available
export PATH="/usr/bin:/bin:$CONDA_ENV/bin:$PATH"

# Reconfigure and build
rm -rf build
mkdir -p build
cd build

/usr/bin/cmake \
  -DCMAKE_PREFIX_PATH="$LIBTORCH_DIR" \
  -DCUDA_TOOLKIT_ROOT_DIR="$CUDA_TARGET" \
  -DCUDA_NVCC_EXECUTABLE="$CONDA_ENV/bin/nvcc" \
  -DCUDA_INCLUDE_DIRS="$CUDA_TARGET/include" \
  -DCUDA_CUDART_LIBRARY="$CUDA_TARGET/lib/libcudart.so" \
  -DCUDAToolkit_ROOT="$CUDA_TARGET" \
  ..

make -j

./example