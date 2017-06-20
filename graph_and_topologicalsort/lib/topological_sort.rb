require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []

  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    vertex = queue.shift
    sorted << vertex
    # vertex.out_edges.each do |out_edges|
    #   child = out_edges.to_vertex
    #   queue << child if child.in_edges.length == 1
    #   child.in_edges.delete(vertex)
    #   out_edges.destroy!
    # end
    (vertex.out_edges.length - 1).downto(0) do |i|
      child = vertex.out_edges[i].to_vertex
      queue << child if child.in_edges.length == 1
      vertex.out_edges[i].destroy!
    end
  end
  vertices.length == sorted.length ? sorted : []
end
