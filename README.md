# Pasos para la ejecucion del programa.

1. Instalar o tener instalada la version 1.8 de ruby

2. Instalar la gema o librería Igraph como se indica en este [enlace](http://igraph.rubyforge.org/igraph/)

3. Desde una terminal, conceder permisos de ejecución para el archivo `main.rb`. 

	`chmod +x main.rb`

4. Para ejecutar el archivo principal, debemos conocer los parametros que recibe este.

	Primer parámetro  -> Poblacion Inicial: Es la cantidad de familias de grafos, los valores recomendados son entre 50 y 100 individuos.
	Segundo parámetro -> Cantidad de nodos: Es el número de nodos que tendrá cada familia de grafos, se recomienda un valor entre 25 y 60. 
	Tercer parámetro  -> Tipo de Grafo: Es el tipo de modelo a ejecutar, 0 para un modelo determinista, 1 para modelo aleatorio.
	Cuarto parámetro  -> Generaciones: Es la cantidad de generaciones que tendrá el algoritmo genético.

   Una vez conocemos los parámetros ejecutamos en una consola el siguiente comando:
	
	`main.rb poblacion nodos tipo_grafo generaciones`
	
Ejemplos de ejecución: 
-`main.rb 100 30 1 40`
-`main.rb 100 30 0 20`
-`main.rb 100 40 0 40`

5. Los resultados del programa se guardarán en un archivo llamado `salida_grafo.txt`