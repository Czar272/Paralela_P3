// Compilar
// nvcc -O3 -o universe src/universe.cu -lm
// Correr
// ./out/universe

#include <stdio.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>

#define NUM_GALAXIES 8          // Numero de galaxias (bloques CUDA)
#define STARS_PER_GALAXY 8      // Numero de estrellas por galaxia (hilos)
#define MAX_BRIGHTNESS 10       // Brillo maximo de una estrella

// Cada bloque representa una galaxia
// Cada hilo dentro del bloque representa una estrella
__global__ void calculateStarBrightness() {
    // blockIdx.x: numero de galaxia (0 a NUM_GALAXIES-1)
    // threadIdx.x: numero de estrella dentro de la galaxia (0 a STARS_PER_GALAXY-1)

    int galaxy = blockIdx.x;
    int star = threadIdx.x;
    
    // Inicializar generador de numeros aleatorios para este hilo
    curandState_t state;
    curand_init(clock64() + threadIdx.x + blockIdx.x * 1000, 0, 0, &state);
    
    // Calcular brillo aleatorio para esta estrella (0-9)
    int brightness = curand(&state) % MAX_BRIGHTNESS;
    
    // Imprimir informacion de la estrella
    printf("Galaxia %d - Estrella %d -> Brillo: %d\n", galaxy, star, brightness);
}

// Funcion Principal
int main() {
    printf("Simulacion de Galaxias en CUDA\n");
    printf("Galaxias (bloques): %d\n", NUM_GALAXIES);
    printf("Estrellas por galaxia (hilos): %d\n", STARS_PER_GALAXY);
    
    // Configurar grid de bloques y threads
    dim3 gridDim(NUM_GALAXIES);          //  bloques
    dim3 blockDim(STARS_PER_GALAXY);     // hilos por bloque
    
    // Lanzar kernel
    calculateStarBrightness<<<gridDim, blockDim>>>();
    
    // Esperar a que terminen todos los calculos
    cudaDeviceSynchronize();
    
    printf("Simulacion completada\n");
    

    return 0;
}
