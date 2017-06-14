require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hashmap = HashMap.new

  string.split("").each_with_index do |char, index|
    if hashmap.include?(char)
      hashmap.delete(char)
    else
      hashmap.set(char, index)
    end
  end

  hashmap.count <= 1
end
