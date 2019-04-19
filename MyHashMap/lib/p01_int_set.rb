class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end

  def insert(num)
   store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    if @store[num] == true
      return true
    else
      return false
    end
  end

  private

  def is_valid?(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      return true
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
    return true
  end

  def remove(num)
    bucket = @store[num % num_buckets]
    num_i = bucket.index(num)
    bucket.delete_at(num_i)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  # def [](num)
  #   i = num % num_buckets
  #   @store[i]
  # end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
