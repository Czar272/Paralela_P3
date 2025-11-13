#include <stdio.h>
    __global__ void helloFromGPU() {
        // cada estrella calculara su brillo (número entre 0 a 9)
        int brillo = (blockIdx.x * threadIdx.x) % 10;
    
        printf("Galaxia: %d, Estrella: %d, brillo: %d\n", blockIdx.x, threadIdx.x, brillo);
    }
    int main() {
    // Llamada al kernel: <<<número de bloques, número de hilos por bloque>>> ## bloques galaxias ## hilos estrellas
    // tendremos 3 galaxias con 10 estrellas cada una
    helloFromGPU<<< 3, 10 >>>();
    cudaDeviceSynchronize();
    return 0;
}