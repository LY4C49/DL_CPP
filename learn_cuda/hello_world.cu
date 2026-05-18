#include <iostream>
#include <math.h>

__global__
void add(int n, float *x, float *y){
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride){
        y[i] = x[i] + y[i];
    }
}

int main(void){
    int N = 1 << 20;
    float *x, *y;
    cudaMallocManaged(&x, N * sizeof(float));
    cudaMallocManaged(&y, N * sizeof(float));
    for (int i = 0; i < N; i++){
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    // add<<<1, 256>>>(N, x, y); // <<<number of blocks, number of threads in each blck >>> OR <<gridsize, blocksizes>>
    
    int blocksize = 256;
    int numberOfBlocks = (N + blocksize - 1) /  blocksize;
    add<<<numberOfBlocks, blocksize>>>(N, x, y);

    cudaDeviceSynchronize();
    float maxError = 0.0f;
    for (int i = 0; i < N; i++){
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    }
    std::cout << "Max Error: " << maxError << std::endl;
    cudaFree(x);
    cudaFree(y);
    return 0;
}