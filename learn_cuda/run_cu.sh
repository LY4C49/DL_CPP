#!/usr/bin/env bash
set -e

CUDA_HOME="$HOME/libs/cuda-13.2"

export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"

echo "===== Compile ====="
"$CUDA_HOME/bin/nvcc" hello_world.cu -o hello_world_cu

echo "===== Run ====="
./hello_world_cu

# echo "===== Nsight Systems Profile ====="
# "$CUDA_HOME/bin/nsys" profile ./hello_world_cu
