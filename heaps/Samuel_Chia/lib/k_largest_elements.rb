require_relative 'heap'

def k_largest_elements(array, k)
  min_heap = BinaryMinHeap.new
  array.each do |el|
    min_heap.push(el)
    min_heap.extract if min_heap.count > k
  end
  min_heap.store
end
