// Compilar
// nvcc -o out/universe src/universe.cu
// Correr
// ./out/universe

#include <stdio.h>

#define NUM_GALAXIES 3
#define STARS_PER_GALAXY 10
#define MAX_BRIGHTNESS 9

// Calcula brillo y asigna numero de galaxias y estrellas por galaxia
__global__ void calculateStarBrightness() {
  int galaxy = blockIdx.x;
  int star = threadIdx.x;

  // Memoria compartida para almacenar brillos por bloque
  extern __shared__ int s_brightness[];

  // Calcular brillo para esta estrella
  int brightness = ((galaxy + 1) * (star + 2)) % (MAX_BRIGHTNESS + 1);

  // Guardar en memoria compartida
  s_brightness[star] = brightness;

  // Esperar a que todos los hilos hayan escrito
  __syncthreads();

  // Un solo hilo por bloque imprime las entradas en orden
  if (threadIdx.x == 0) {
    printf(">>> Galaxia %d completa:\n", galaxy);
    for (int i = 0; i < blockDim.x; ++i) {
      printf("Estrella %d -> Brillo: %d\n", i, s_brightness[i]);
    }
  }
}

int main() {

  // Reservar memoria compartida: un entero por estrella
  size_t shared_mem = STARS_PER_GALAXY * sizeof(int);

  calculateStarBrightness<<<NUM_GALAXIES, STARS_PER_GALAXY, shared_mem>>>();

  cudaDeviceSynchronize();
  return 0;
}
