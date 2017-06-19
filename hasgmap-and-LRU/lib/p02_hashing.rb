class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0.hash
    self.each_with_index do |element, index|
      hashed += element.hash % index.hash
    end
    hashed
  end
end

class String
  def hash
    hashed = 0.hash
    self.split("").each_with_index do |char, index|
      hashed += char.ord.hash % index.hash
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0.hash
    self.each do |key, value|
      hashed += key.hash % value.hash
    end
    hashed
  end
end
