class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    if first == @tail && last == @head
      return true
    else
      return false
    end
  end

  def get(key)
    self.each do |node|
      if node.key == key
        node.val
      end
    end
    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      else
        return false
      end
    end
  end

  def append(key, val)
    new_node = Node.new(key,val)
    if self.empty?
      new_node.prev = @head
      @head.next = new_node
      new_node.next = @tail
      @tail.prev = new_node
    else
      new_node.prev = self.last
      self.last.next = new_node
      new_node.next = @tail
      @tail.prev = new_node
    end
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(k)
    self.each do |node|
      if node.key == k
        node.remove
      end
    end
  end

  def each(&prc)
    current = first

    until current.key == @tail.key
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
