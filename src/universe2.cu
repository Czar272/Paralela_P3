// nvcc -o out/universe2 src/universe2.cu

#include <stdio.h>

__global__ void UniverseSim() {
  // cada estrella calculara su brillo
  int brillo = (blockIdx.x * threadIdx.x) % 10;

  printf("Galaxia: %d, Estrella: %d, brillo: %d\n", blockIdx.x, threadIdx.x,
         brillo);
}
int main() {
  // Llamada al kernel: <<<número de bloques, número de hilos por bloque>>> ##
  // bloques galaxias ## hilos estrellas tendremos 3 galaxias con 10 estrellas
  // cada una
  UniverseSim<<<3, 10>>>();
  cudaDeviceSynchronize();
  return 0;
}