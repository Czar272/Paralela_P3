# Preguntas respondidas por Pablo Cesar Lopez Medina - 22535

1. ¿Que aprendiste sobre como CUDA distribuye el trabajo entre hilos y bloques?

    Aprendi que CUDA divide el trabajo en bloques (que representan galaxias en nuestro caso) y cada bloque tiene multiples hilos (estrellas). Cada hilo ejecuta el mismo código pero con indices diferentes (blockIdx.x y threadIdx.x). 

2. ¿Que fue lo mas dificil de entender del paralelismo?

    Lo mas dificil fue entender que el orden de ejecucion no esta garantizado. Cuando imprimes directamente desde el kernel, las estrellas de la Galaxia 2 pueden imprimir antes que las de la Galaxia 0, incluso aunque el codigo del bloque 0 este primero. Al principio pense que los bloques se ejecutaban secuencialmente, pero en realidad son completamente independientes y pueden ejecutarse en cualquier orden.

3. Si pudieras mejorar el laboratorio, ¿que cambio harias en el algoritmo?

    Talvez añadiria tablas que muestren como se distribuyen los bloques en la GPU y un comparador entre version CPU (secuencial) y GPU (paralela) mostrando tiempos.

4. ¿Que analogia del mundo real usarias para explicar el concepto de "sincronizacion de hilos"?

    La sincronizacion es como cuando un maestro del curso de Comptuacion Paralela Distribuida que casualmente se llama Luis, deja a los estudiantes (hilos) trabajar en grupos (bloques) en un proyecto. Todos deben terminar su parte antes de pasar a la siguiente fase. Si uno termina rapido, tiene que esperar a los demas en un punto de encuentro.

5. ¿Como verificarias que realmente se esta ejecutando en GPU y no en CPU?

    Al ejecutar nvidia-smi en la terminal se puede ver el uso de la GPU en tiempo real mientras corre el programa. Si no usa GPU, la GPU muestra 0%.
