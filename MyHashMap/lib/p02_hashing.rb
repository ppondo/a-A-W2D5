class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash = 0
    self.each_with_index do |el, i|
      hash = hash^(el.hash * i)
    end

    hash
  end
end

class String
  def hash
    alpha = ('a'..'z').to_a
    hash = 0
    spl = self.split('')

    spl.each_with_index do |el, i|
      idx = alpha.index(el)
      hash = hash^(idx.hash * i)
    end

    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0
    self.each do |k,v|
      hash += k.hash + v.hash
    end

    hash
    0
  end
end
