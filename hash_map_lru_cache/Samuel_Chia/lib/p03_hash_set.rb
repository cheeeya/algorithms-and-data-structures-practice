require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    raise "#{key} already exists in set" if include?(key)
    @count += 1
    resize! if (@count > num_buckets)
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    deleted = self[key].delete(key)
    @count -= 1 if deleted
    deleted
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_store = Array.new(new_size) { Array.new }
    @store.each do |arr|
      arr.each do |key|
        new_store[key.hash % new_size] = key
      end
    end
    @store = new_store
  end
end
