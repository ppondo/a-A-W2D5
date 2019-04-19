class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    hashed = key.hash

    unless include?(key)
      @store[hashed % num_buckets] << key 
      @count += 1
      return true
    end
  end

  def include?(key)
    hashed = key.hash
    @store[hashed % num_buckets].include?(key)
  end

  def remove(key)
    hashed = key.hash
    if include?(key)
      bucket = @store[hashed % num_buckets]
      key_i = bucket.index(key)
      bucket.delete_at(key_i)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    keys = []
    
    @store.each do |bucket|
      bucket.each do |key|
        keys << key
        self.remove(key) 
      end
    end

    num_buckets.times { @store << [] }

    keys.each { |key| self.insert(key) }
  end
end
