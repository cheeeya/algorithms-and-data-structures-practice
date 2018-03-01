require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new { |a,b| -1 * (a <=> b) }
  min_heap = BinaryMinHeap.new
  largest = []
  array.each do |el|
    min_heap.push(el)
    if (min_heap.count > k)
      min_heap.extract
    end
  end
  min_heap.store
end
