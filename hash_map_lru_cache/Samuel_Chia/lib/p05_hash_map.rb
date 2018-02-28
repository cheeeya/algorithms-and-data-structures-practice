require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  # O(1) in theory if each bucket has 1 item
  def include?(key)
    bucket(key).include?(key)
  end

  # might not need to check for inclusion
  # if modify update method to return a value on successful update or nil
  # O(1) for appending, O(1) for updating if each bucket has 1 item
  def set(key, val)
    return bucket(key).update(key, val) if include?(key)
    @count += 1
    resize! if @count > num_buckets
    bucket(key).append(key, val)
  end

  # O(1) if each bucket has 1 item
  def get(key)
    bucket(key).get(key)
  end

  # O(1) if each bucket has 1 item
  def delete(key)
    deleted = bucket(key).remove(key)
    @count -= 1 if deleted
    deleted
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield node.key, node.val
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  # O(n)
  def resize!
    new_size = num_buckets * 2
    new_store = Array.new(new_size) { LinkedList.new }
    each { |key, val| new_store[key.hash % new_size].append(key, val) }
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
