class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    if (prc)
      @prc = prc
    else
      @prc = Proc.new { |a, b| a <=> b }
    end
    @store = Array.new
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count-1], @store[0]
    BinaryMinHeap.heapify_down(@store, 0, count - 1, &@prc)
    @store.pop
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    1.upto(2) do |i|
      child = parent_index * 2 + i
      break if child > len - 1
      child_indices << child
    end
    child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= BinaryMinHeap.new.prc
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    return array if child_indices.empty?

    if (child_indices.length == 1)
      child_idx = child_indices[0]
    else
      child_idx = prc.call(array[child_indices[0]], array[child_indices[1]]) == 1 ?
        child_indices[1] : child_indices[0]
    end

    case prc.call(array[parent_idx], array[child_idx])
    when 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
    else
      array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= BinaryMinHeap.new.prc
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    case prc.call(array[child_idx], array[parent_idx])
    when -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    else
      array
    end
  end
end
