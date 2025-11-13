// Compilar
// nvcc -o out/universe src/universe.cu
// Correr
// ./out/universe

#include <stdio.h>

#define NUM_GALAXIES 3
#define STARS_PER_GALAXY 10
#define MAX_BRIGHTNESS 9

// Calcula brillo y asigna numero de galaxias y estrellas por galaxia
__global__ void calculateStarBrightness(int *out) {
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

  // Escribir resultado en arreglo global (orden: galaxy-major)
  int index = galaxy * blockDim.x + star;
  out[index] = s_brightness[star];
}


int main() {

  // Reservar memoria compartida: un entero por estrella
  size_t shared_mem = STARS_PER_GALAXY * sizeof(int);

  // Reservar arreglo para brillos en device
  int total = NUM_GALAXIES * STARS_PER_GALAXY;
  int *d_brightness = NULL;
  if (cudaMalloc(&d_brightness, total * sizeof(int)) != cudaSuccess) {
    fprintf(stderr, "Error: cudaMalloc failed\n");
    return 1;
  }

  // Lanzar kernel (cada bloque usa shared_mem bytes)
  calculateStarBrightness<<<NUM_GALAXIES, STARS_PER_GALAXY, shared_mem>>>(d_brightness);
  cudaDeviceSynchronize();

  // Copiar resultados al host
  int *h_brightness = (int *)malloc(total * sizeof(int));
  cudaMemcpy(h_brightness, d_brightness, total * sizeof(int), cudaMemcpyDeviceToHost);
  
  // Calcular suma total y promedio por galaxia
  int sumaBrilloPorGalaxia[NUM_GALAXIES] = {0};
  float brilloPromedioPorGalaxia[NUM_GALAXIES] = {0.0f};
  
  for (int g = 0; g < NUM_GALAXIES; ++g) {
    int sumaBrillo = 0;
    for (int s = 0; s < STARS_PER_GALAXY; ++s) {
      sumaBrillo += h_brightness[g * STARS_PER_GALAXY + s];
    }
    sumaBrilloPorGalaxia[g] = sumaBrillo;
    brilloPromedioPorGalaxia[g] = (float)sumaBrillo / STARS_PER_GALAXY;
  }

  // Imprimir detalles de cada galaxia
  for (int g = 0; g < NUM_GALAXIES; ++g) {
    printf(">>> Galaxia %d completa\n", g);
    for (int s = 0; s < STARS_PER_GALAXY; ++s) {
      int val = h_brightness[g * STARS_PER_GALAXY + s];
      printf("  Estrella %d -> Brillo: %d\n", s, val);
    }
    printf("Suma total de brillo: %d\n", sumaBrilloPorGalaxia[g]);
  }
  
  printf("\n");
  
  // Imprimir brillo promedio de todas las galaxias
  for (int g = 0; g < NUM_GALAXIES; ++g) {
    printf(">>> Galaxia %d - Brillo promedio: %.2f\n", g, brilloPromedioPorGalaxia[g]);
  }
  
  printf("\n");
  // Liberar memoria
  free(h_brightness);
  cudaFree(d_brightness);

  return 0;
}
