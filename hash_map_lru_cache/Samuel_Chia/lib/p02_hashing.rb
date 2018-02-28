class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    array_hash = 685495564
    self.each_with_index do |el, idx|
      if el.is_a?(Integer)
        array_hash += el.hash * idx.hash
      elsif el.is_a?(String)
        array_hash += (el.ord * -2018595405) * idx.hash
      end
    end
    array_hash
  end
end

class String
  def hash
    return -1623050269 if self.empty?
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_num = 1043638799
    self.each do |key, val|
      hash_num += (key.to_s.hash + 1837873649) * val.to_s.hash
    end
    hash_num
  end
end
