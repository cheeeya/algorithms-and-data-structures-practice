require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

#Khan's Algorithm
def topological_sort(vertices)
  sorted = Array.new
  q = Queue.new
  vertices.each do |v|
    if v.in_edges.empty?
      return [] if v.out_edges.empty?
      q.enq(v)
    end
  end
  until q.empty?
    current = q.deq
    sorted << current
    until current.out_edges.empty?
      edge = current.out_edges.first
      v = edge.to_vertex
      edge.destroy!
      q.enq(v) if v.in_edges.empty?
    end
  end
  return sorted if sorted.length == vertices.length
  []
end
