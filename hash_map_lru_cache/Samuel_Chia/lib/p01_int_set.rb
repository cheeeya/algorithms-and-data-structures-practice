class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
    nil
  end

  def remove(num)
    validate!(num)
    @store[num] = false
    num
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > -1 && num < @store.length
  end

  def validate!(num)
    raise "Out of bounds" if !is_valid?(num)
  end
end

# int set implemented using 2D array with fixed size
class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    raise "#{num} already exists in set" if include?(num)
    self[num] << num
    nil
  end

  def remove(num)
    # raise "#{num} does not exist in set" if !include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

# int set implemented with 2d array
# that resizes when number of elements > number of buckets
class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # average case O(1)
  # worst case O(n) if all nums fall into the same bucket
  def insert(num)
    raise "#{num} already exists in set" if include?(num)
    @count += 1
    resize! if @count > num_buckets
    self[num] << num
    nil
  end

  # O(1)
  # worst case O(n) if all nums fall into the same bucket & check for existance
  # can eliminate worst case by not checking for inclusion
  # if statement not necessary if check for inclusion
  def remove(num)
    # raise "#{num} does not exist in set" if !include?(num)
    deleted = self[num].delete(num)
    @count -= 1 if !deleted.nil?
    deleted
  end

  # average case O(1), each array "bucket" will typically have 1 element
  # worst case O(n) if all nums fall into the same bucket
  def include?(num)
    self[num].include?(num)
  end

  def inspect
    @store
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  # O(n) to resize, must grab every element and push into new array
  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |num|
        new_store[num % (num_buckets * 2)] << num
      end
    end
    @store = new_store
  end
end
