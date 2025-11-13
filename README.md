# Simulación de Galaxias en CUDA


## Fase 1
#### Preguntas de validación
1. ¿Qué relación existe entre blockIdx.x y el número de galaxia impreso?
    El blockIdx.x es el indice de cada bloque, entonces simplemente es el numero de galaxia que se imprimio

2. ¿Qué representa threadIdx.x dentro de tu simulación?
    Es el numero de thread dentro del bloque, entonces representa el numero de estrella dentro de cada galaxia

3. Si duplicas la cantidad de estrellas, ¿cambia el orden de impresión o solo el
tamaño de la salida?
    Solo cambia el tamaño de la salida

4. ¿Qué representa el “brillo” dentro de este modelo paralelo?
    en nuestro caso el brillo se calcula con: ((galaxy + 1) * (star + 2)) % MAX_BRIGHTNESS. Por lo que es un calculo realizado para cada estrella, y demuestra como cada hilo puede realizar calculos en paralelo.

## Fase 2
#### Preguntas de validación
1. ¿Qué ocurre si eliminas la sincronización?
Puede que hayan problemas de race condition con algunos hilos al acceder a s_brightness antes de que otros hilos terminen de escribir, por lo que obtendiramos valores incorrectos dandonos diferentes resultados en cada ejecucion.

2. ¿Qué significa que “__syncthreads() solo sincroniza dentro de un bloque”?
es una barrera local, por lo que funciona dentro del mismo bloque, y los hilos de otro bloque no estan afectados entre si.

3. ¿Por qué la sincronización entre galaxias (bloques diferentes) no es posible
directamente?
No es posible la sincronizacion entre galaxias dado que cada bloque es independiente, pueden ejecutarse en paralelo o secuencial. Por lo que los bloques se pueden ejecutar de diferente orden

4. ¿Qué tipo de errores podrían aparecer si las estrellas imprimen sin
coordinarse?
Si las estrellas imprimen sin cordinarse puede que hayan valores incorrectos , tambien afectaria en el output provocando texto ilegible mezclado entre hilos, tambien afectaria en resultados ya que algunos hilos terminan antes que otros.

## Fase 3
### Preguntas de validacion

1. ¿Por qué es útil la memoria compartida en este contexto?

    La memoria compartida es útil porque permite que todos los hilos dentro de un bloque (galaxia) accedan rápidamente a los datos de todas las estrellas. En nuestro código, cada hilo calcula su brillo y lo guarda en s_brightness[]. Luego, todos pueden leer estos valores sin tener que acceder a memoria global.

2. ¿Qué ventaja tiene frente al uso de memoria global?

    Velocidad. La memoria compartida es mucho más rápida que memoria global. En nuestro código, si todos los hilos escribieran directamente en out[] (memoria global) en lugar de usar s_brightness[], sería mucho más lento porque cada hilo tendría que escribir en un área diferente de memoria global.

3. ¿Qué pasaría si más de una estrella intenta escribir al mismo tiempo en la misma posición?

    Se produciría una race condition. En nuestro código, esto no sucede porque cada hilo escribe en s_brightness[star]. Pero si dos hilos intentaran escribir en el mismo índice los escrituras serían no-deterministas. Por eso usamos __syncthreads() y aseguramos que cada hilo tiene su propio espacio s_brightness[threadIdx.x].