#! /usr/bin/ruby

require 'Salida.rb'

class Main2

  #Parametros para la salida
  
  cromosoma=[1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0]
  vecindad=2
  cantidad_nodos=40
  tipo_grafo=0
  nodo_a=773
  nodo_p=1112
  nodo_m=852
  
  salida = Salida.new(cantidad_nodos,vecindad,cromosoma,tipo_grafo)
  
  salida.imprimir_grafo()
  salida.imprimir_rutas(nodo_a,nodo_p,nodo_m)
  

end