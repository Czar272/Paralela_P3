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

  // Calcular brillo para esta estrella
  int brightness = ((galaxy + 1) * (star + 2)) % MAX_BRIGHTNESS;

  printf("Galaxia %d - Estrella %d -> Brillo: %d\n", galaxy, star, brightness);
}

int main() {

  calculateStarBrightness<<<NUM_GALAXIES, STARS_PER_GALAXY>>>();

  cudaDeviceSynchronize();
  return 0;
}
