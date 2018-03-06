# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

def install_order(arr)
  order = []
  q = Queue.new
  h = Hash.new { Array.new { Array.new } }
  max_id = 0
  arr.each do |tuple|
    max_id = tuple.max if tuple.max > max_id
    h[tuple[0]] = [[],[]] if h[tuple[0]].empty?
    h[tuple[1]] = [[],[]] if h[tuple[1]].empty?
    h[tuple[0]][0] << tuple[1]
    h[tuple[1]][1] << tuple[0]
  end

  1.upto(max_id) do |i|
    h[i] = [[],[]] if h[i].empty?
    q.enq(i) if h[i][0].empty?
  end
  until q.empty?
    current = q.deq
    order << current
    end_v = h[current][1]
    until end_v.empty?
      dependent = end_v.first
      from_v = h[dependent][0]
      from_v.delete(current)
      end_v.delete(dependent)
      q.enq(dependent) if from_v.empty?
    end
  end
  order
end
