class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    array_hash = 685495564
    self.each_with_index do |el, idx|
      if el.is_a?(Integer)
        array_hash += (el.to_s(2).to_i).hash * (idx + 2)
      elsif el.is_a?(String)
        array_hash += el.unpack("B*")[0].to_i.hash * (idx + 2)
      end
    end
    array_hash
  end
end

class String
  def hash
    ([self].hash - 685495564) / 2
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_num = 104363879
    self.each do |key, val|
      hash_num += (key.to_s.hash + 1837873649) * val.to_s.hash
    end
    hash_num
  end
end
