require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    check_index(0)
    @length -= 1
    @store[(@length + @start_idx) % @capacity]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@length + @start_idx) % @capacity] = val
    @length += 1
    @store
  end

  # O(1)
  def shift
    check_index(0)
    @length -= 1
    @start_idx = (@start_idx + 1) % @capacity
    @store[(@start_idx - 1) % @capacity]
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index > @length - 1
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times do |i|
      new_store[i] = @store[(@start_idx + i) % (@capacity / 2)]
    end
    @start_idx = 0
    @store = new_store
  end
end
