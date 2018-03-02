class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot_idx = rand(array.length)
    pivot = array[pivot_idx]
    left, right = Array.new
    array.each_with_index do |el, idx|
      next if idx == pivot_idx
      case el <=> pivot
      when 1
        right << el
      else
        left << el
      end
    end
    return QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length < 2
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    # pivot_idx = rand(length) + start
    # array[start], array[pivot_idx] = array[pivot_idx], array[start]
    boundary = start
    (start + 1).upto(start + length - 1) do |i|
      case prc.call(array[i], array[start])
      when -1
        array[i], array[boundary + 1] = array[boundary + 1], array[i]
        boundary += 1
      end
    end
    array[start], array[boundary] = array[boundary], array[start]
    boundary
  end
end
