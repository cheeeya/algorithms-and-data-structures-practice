require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |a,b| -1 * (a <=> b) }
    self.length.times do |i|
      BinaryMinHeap.heapify_up(self, i, i + 1, &prc)
    end
    self.length.times do |i|
      self[0], self[self.length - i - 1] = self[length - i- 1], self[0]
      BinaryMinHeap.heapify_down(self, 0, self.length - i - 1, &prc)
    end
  end
end
