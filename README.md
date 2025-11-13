# Simulación de Galaxias en CUDA


## Fase 1

#### Preguntas
1. ¿Qué relación existe entre blockIdx.x y el número de galaxia impreso?
    El blockIdx.x es el indice de cada bloque, entonces simplemente es el numero de galaxia que se imprimio

2. ¿Qué representa threadIdx.x dentro de tu simulación?
    Es el numero de thread dentro del bloque, entonces representa el numero de estrella dentro de cada galaxia

3. Si duplicas la cantidad de estrellas, ¿cambia el orden de impresión o solo el
tamaño de la salida?
    Solo cmabia el tamaño de la salida

4. ¿Qué representa el “brillo” dentro de este modelo paralelo?
    en nuestro caso el brillo se calcula con: ((galaxy + 1) * (star + 2)) % MAX_BRIGHTNESS, 