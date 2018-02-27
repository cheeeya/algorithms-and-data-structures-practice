# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_store = [] #probably want to use a max_heap
  end

  def enqueue(val)
    @store.push(val)
    if @max_store.empty? || val >= @max_store.last
      @max_store.push(val)
    elsif val <= @max_store.first
      @max_store.unshift(val)
    else
      @max_store = insert(@max_store, val)
    end
  end

  def dequeue
    val = @store.shift
    @max_store.delete(val) #O(n) complexity lol
  end

  def max
    @max_store.last
  end

  def length
    @store.length
  end

  def insert(arr, val)
    mid = arr.length / 2
    p arr
    if (arr.length < 2)
      return arr.push(val).sort
    end
    if val == arr[mid]
      result = arr[0..mid] + arr[mid..-1]  #is concating O(n)??
    elsif val > arr[mid]
      result = arr[0..mid] + insert(arr[mid+1..-1], val)
    else
      result = insert(arr[0...mid], val) + arr[mid..-1]
    end
    result
  end


end
