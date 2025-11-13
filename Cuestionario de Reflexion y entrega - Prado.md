# Preguntas respondidas por Javier Alejandro Prado Ramirez - 21486
1. ¿Qué aprendiste sobre cómo CUDA distribuye el trabajo entre hilos y bloques?
Aprendi que con CUDA distribuye el trabajo entre multiples hilos de la GPU, y divide el trabajo entre los hilos y bloques con esto nos permite dividir tareas complejas en miles o millones de pequeñas tareas, que luego son ejecutadas simultáneamente en los núcleos de la GPU.
2. ¿Qué fue lo más difícil de entender del paralelismo?
Me costo saber que tareas dividir para optimizar el programa, y el uso del manejo de asignar que hacer en las tareas de los hilos.

3. Si pudieras mejorar el laboratorio, ¿qué cambio harías en el algoritmo?
mejoraria la sincronizacion posible para optimizar los calculos promedios de cada estrella.
4. ¿Qué analogía del mundo real usarías para explicar el concepto de
“sincronización de hilos”?
Mi anologia es como al momento de que varios chefs estan haciedno una pizza, y cada chef tiene su tarea asociada, cada chef tiene que esperar a que ponga su ingriente a la piza para poder que la pizza salga bien cada chef se tiene que sincronizar con los demas.

5. ¿Cómo verificarías que realmente se está ejecutando en GPU y no en CPU?
en windows ver en admin de tareas el rendimiento GPU.