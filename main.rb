#! /usr/bin/ruby

require 'AG.rb'

class Main
	
  poblacion=ARGV[0].to_i
  nodos=ARGV[1].to_i
  tipo_grafo=ARGV[2].to_i
  vecindad=ARGV[3].to_i
  generaciones=ARGV[4].to_i

  ag=AG.new(poblacion,nodos,tipo_grafo,vecindad)

  fsalida=File.new('salida_evolucion.txt','w')
  i=0
  t = Time.now
  fsalida.puts "poblacion #{poblacion}, nodos #{nodos}, tipo de grafo #{tipo_grafo}, vecindad #{vecindad}"
  fsalida.puts "Tiempo de inicio AG #{t.strftime("%d/%m/%Y %H:%M:%S")}"
  #ag.evolucion()
  generaciones.times{
    at=rand(10)
    ag.evolucion()
    puts "Generacion #{i}"
    fsalida.puts "Generacion #{i}"
    fsalida.puts ag.aptitudes.inspect
    #fsalida.puts ag.poblacion[at].aptitud.inspect
    fsalida.puts ag.poblacion[at].cromosoma.inspect
    fsalida.puts ag.poblacion[at].datos.inspect
    fsalida.puts ag.poblacion[at].histograma.inspect
    fsalida.puts "\n\n"
    i=i+1
  }

  t = Time.now
  fsalida.puts "Tiempo fin AG #{t.strftime("%d/%m/%Y %H:%M:%S")}"
  fsalida.close

end
