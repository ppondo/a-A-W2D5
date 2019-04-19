require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    hashed = key.hash
    @store[hashed % num_buckets].include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets
    hashed = key.hash

    if include?(key)
      @store[hashed % num_buckets].update(key,val)
    else
      @store[hashed % num_buckets].append(key,val) 
      @count += 1
      return true
    end
  end

  def get(key)
    hashed = key.hash
    list = @store[hashed % num_buckets]
    if self.include?(key)
      return list.get(key)
    else
      return nil
    end
  end

  def delete(key)
    hashed = key.hash
    list = @store[hashed % num_buckets]

    list.remove(key)
    @count -= 1
  end

  def each
    # self.each do |list|
    #   current = first
    #   until current.key == @tail.key
    #     prc.call(current)
    #     current = current.next
    #   end
    # end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    hash = {}
    
    @store.each do |bucket|
      bucket.each do |node|
        hash[node.key] = node.val
        self.delete(node.key) 
      end
    end

    num_buckets.times { @store << LinkedList.new }

    hash.each { |key, val| self.set(key, val) }
  end

  def bucket(key)
    # hashed = key.hash
    # @store[hashed % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
