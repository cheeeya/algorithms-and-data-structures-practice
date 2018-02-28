require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  map = HashMap.new
  string.chars.each do |letter|
    map.include?(letter) ? map.delete(letter) : map[letter] = true
  end
  map.count < 2
end
