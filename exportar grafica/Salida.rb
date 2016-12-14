#! /usr/bin/ruby

require 'rubygems'
require 'igraph'

class Salida

  attr_accessor :graph, :cromosoma, :aptitud, :datos, :errores, :cantidad_nodos, :vecindad, :histograma, :tipo_grafo
  def initialize (num_nodos,vecindad,cromosoma,tipo_grafo)

    @vecindad=vecindad
    @cromosoma = cromosoma
    @cantidad_nodos=num_nodos
    @tipo_grafo=tipo_grafo

    graph = IGraph::Generate.lattice([num_nodos,num_nodos],false,false,false)

    #eliminamos aristas previamente anadidas por Generate.lattice
    #puts "eliminando aristas por defecto"
    graph.each {|vertex|
      graph.neighbours(vertex,IGraph::ALL).each{ |neighbour|
        if graph.are_connected?(vertex,neighbour)
          graph.delete_edge(vertex,neighbour)
          #puts "Arista eliminada del vertice #{v} al vertice #{n}"
        end
      }
    }
    #puts "done"
    
    if tipo_grafo==1 then 
    @graph = procesar_aristas_tipo0(graph,@cromosoma)
    else
      @graph = procesar_aristas_tipo1(graph,@cromosoma,0.5)
    end    
  end

  def procesar_aristas_tipo0(graph,cromosoma)
    #puts "procesando aristas"

    n=Math.sqrt(graph.vcount())

    vecinos=[]
    index_rot1=[]
    index_rot2=[]
    index_rot3=[]
    if @vecindad == 1 #Parametros para definir los vecinos de un nodo i, 8 vecinos
      vecinos=[-(n+1),-n,-(n-1),-1,1,(n-1),n,(n+1)]
      index_rot1=[5,3,0,6,1,7,4,2]
      index_rot2=[7,6,5,4,3,2,1,0]
      index_rot3=[2,4,7,1,6,0,3,5]
    else
      if @vecindad == 2 # 23 vecinos
        vecinos=[-(n*2+2),-(n*2+1),-(n*2),-(n*2-1),-(n*2-2),
          -(n+2),-(n+1),-n,-(n-1),-(n-2),
          -2,-1,1,2,
          (n-2),(n-1),n,(n+1),(n+2),
          (n*2-2),(n*2-1),(n*2),(n*2+1),(n*2+2)]
        index_rot1=[19,14,10,5,0,20,15,11,6,1,21,16,7,2,22,17,12,8,3,23,18,13,9,4]
        index_rot2=[23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
        index_rot3=[4,9,13,18,23,2,8,12,17,22,2,7,16,21,1,6,11,15,20,0,5,10,14,19]
      end
    end

    vertice = n+1
    while vertice<((n*n)-(n+1))
      #definir las aristas para los nodos del primer cuadrante
      if vertice % n < (n-(n/2)) and vertice <= ((n*n)-1)/2 #primer cuadrante
        cromosoma.each_index{ |i|
          if cromosoma[i]==1
            #puts vertice+vecinos[i]
            if vertice+vecinos[i]>0
              graph.add_edge(vertice,vertice+vecinos[i])
              #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
            end
          end
        }
      end
      #definir las aristas para los nodos del segundo cuadrante
      if vertice % n >= (n-(n/2)) and vertice <= (((n*n)-1)/2) + ((n/2)-1)  #segundo cuadrante
        cromosoma.each_index{ |i|
          if cromosoma[index_rot1[i]]==1
            if vertice+vecinos[i]>0
              graph.add_edge(vertice,vertice+vecinos[i])
              #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
            end
          end
        }
      end
      #definir las aristas para los nodos del tercer cuadrante
      if vertice % n >= (n-(n/2)) and  vertice >= (((n*n)-1)/2)+n and vertice <= ((n*n)-1) - (n+1)  #tercer cuadrante
        cromosoma.each_index{ |i|
          if cromosoma[index_rot2[i]]==1
            if vertice+vecinos[i]<n*n
              graph.add_edge(vertice,vertice+vecinos[i])
              #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
            end
          end
        }
      end
      #definir las aristas para los nodos del cuarto cuadrante
      if vertice >= (((n*n)-1)/2) + ((n/2)-1) + 3 and vertice % n <= (n-(n/2)-1)  #cuarto cuadrante
        cromosoma.each_index{ |i|
          if cromosoma[index_rot3[i]]==1
            if vertice+vecinos[i]<n*n
              graph.add_edge(vertice,vertice+vecinos[i])
              #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
            end
          end
        }
      end

      #aumento de indice
      if vertice % n == (n-2)
        vertice +=3
      else
        vertice += 1
      end

    end
    #puts "done"

    return graph

  end
  
def round_to(a,x)
  (a * 10**x).round.to_f / 10**x
end

def procesar_aristas_tipo1(graph,cromosoma,r)
  #puts "procesando aristas"
  r=0.5
  n=Math.sqrt(graph.vcount())
  vecinos=[]
      index_rot1=[]
      index_rot2=[]
      index_rot3=[]
      if @vecindad == 1
        vecinos=[-(n+1),-n,-(n-1),-1,1,(n-1),n,(n+1)]
        index_rot1=[5,3,0,6,1,7,4,2]
        index_rot2=[7,6,5,4,3,2,1,0]
        index_rot3=[2,4,7,1,6,0,3,5]
      else
        if @vecindad == 2
          vecinos=[-(n*2+2),-(n*2+1),-(n*2),-(n*2-1),-(n*2-2),
            -(n+2),-(n+1),-n,-(n-1),-(n-2),
            -2,-1,1,2,
            (n-2),(n-1),n,(n+1),(n+2),
            (n*2-2),(n*2-1),(n*2),(n*2+1),(n*2+2)]
          index_rot1=[19,14,10,5,0,20,15,11,6,1,21,16,7,2,22,17,12,8,3,23,18,13,9,4]
          index_rot2=[23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
          index_rot3=[4,9,13,18,23,2,8,12,17,22,2,7,16,21,1,6,11,15,20,0,5,10,14,19]
        end
      end

  vertice = n+1
  while vertice<((n*n)-(n+1))

    if vertice % n < (n-(n/2)) and vertice <= ((n*n)-1)/2 #primer cuadrante
            cromosoma.each_index{ |i|
              if cromosoma[i]<r
                #puts vertice+vecinos[i]
                if vertice+vecinos[i]>0
                  graph.add_edge(vertice,vertice+vecinos[i])
                  #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
                end
              end
            }
          end
    
          if vertice % n >= (n-(n/2)) and vertice <= (((n*n)-1)/2) + ((n/2)-1)  #segundo cuadrante
            cromosoma.each_index{ |i|
              if cromosoma[index_rot1[i]]<r
                if vertice+vecinos[i]>0
                  graph.add_edge(vertice,vertice+vecinos[i])
                  #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
                end
              end
            }
          end
    
          if vertice % n >= (n-(n/2)) and  vertice >= (((n*n)-1)/2)+n and vertice <= ((n*n)-1) - (n+1)  #tercer cuadrante
            cromosoma.each_index{ |i|
              if cromosoma[index_rot2[i]]<r
                if vertice+vecinos[i]<n*n
                  graph.add_edge(vertice,vertice+vecinos[i])
                  #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
                end
              end
            }
          end
    
          if vertice >= (((n*n)-1)/2) + ((n/2)-1) + 3 and vertice % n <= (n-(n/2)-1)  #cuarto cuadrante
            cromosoma.each_index{ |i|
              if cromosoma[index_rot3[i]]<r
                if vertice+vecinos[i]<n*n
                  graph.add_edge(vertice,vertice+vecinos[i])
                  #puts "Arista anadida del vertice #{vertice} al vertice #{vertice+vecinos[i]}"
                end
              end
            }
          end

    #aumento de indice
    if vertice % n == (n-2)
      vertice +=3
    else
      vertice += 1
    end

  end
  #puts "done"

  return graph

end
    
  
  
  def imprimir_grafo()
    fsalida=File.new('ver_grafo.graphml','w')
    @graph.write_graph_graphml(fsalida)
    fsalida.close
  
  end

  def imprimir_rutas(nodo_a, nodo_p, nodo_m)
    
    fsalida=File.new('rutas.txt','w')
   

    ruta_a_m=graph.get_shortest_paths(nodo_a,[nodo_m],IGraph::ALL)
    ruta_p_m=graph.get_shortest_paths(nodo_p,[nodo_m],IGraph::ALL)
    ruta_a_p=graph.get_shortest_paths(nodo_a,[nodo_p],IGraph::ALL)
    fsalida.puts "Ruta nodo A-M"
    fsalida.puts ruta_a_m.inspect
    fsalida.puts "Ruta nodo P-M"
    fsalida.puts ruta_p_m.inspect
    fsalida.puts "Ruta nodo A-P"
    fsalida.puts ruta_a_p.inspect

    puts "Archivo escrito."
  end

end

