class Node
  def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
  end

  attr_accessor :value, :next_node
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next_node = @tail
    @size = 0
  end

  attr_reader :size, :head, :tail

  def append(val)
    new_tail_node = Node.new
    if @head.value.nil?
      @head.value = val
    else
      @tail.value = val
      @tail.next_node = new_tail_node
      @tail = @tail.next_node
    end
    @size += 1
  end

  def prepend(val)
    if @head.value.nil?
      @head.value = val
    else
      @head = Node.new(value = val, next_node = @head)
    end
    @size += 1
  end

  def to_s
    if @head.value.nil?
      print "(#{@head.value})\n"
    else
      print "(#{@head.value}) -> "
      next_node = @head.next_node
      while next_node.value != nil
        print "(#{next_node.value}) -> "
        next_node = next_node.next_node
      end
      print "(#{@tail.value})\n"
    end
  end

  def fetch_node(index)
    next_node = @head
    i = 1
    while i <= index
      next_node = next_node.next_node
      i += 1
    end
    return next_node
  end

  def at(index)
    if index >= @size || index<0
      return nil
    end
    return fetch_node(index).value
  end

  def pop
    if @size>1
      penultimate_node = fetch_node(@size-2)
      last_node = fetch_node(@size-1)
      penultimate_node.next_node = Node.new
      @tail = penultimate_node.next_node
      @size -= 1
      return last_node.value
    elsif @size === 1
      z = @head.value
      @head.value = nil
      @size -= 1
      return z
    else
      return nil
    end
  end

  def contain?(val)
    i = 0
    while i < @size
      if fetch_node(i).value === val
        break
      end
      i += 1
    end
    return i === @size? false:true
  end

  def fetch_index(val)
    i = 0
    while i < @size
      if fetch_node(i).value === val
        break
      end
      i += 1
    end
    return i<@size? i:nil
  end

  def insert_at(val, idx)
    if idx === 0
      prepend(val)
    end
    if idx === @size
      append(val)
    end
    if idx<@size && idx>0
      new_next_node = Node.new(value = val, next_node = fetch_node(idx))
      fetch_node(idx-1).next_node = new_next_node
    else
      return nil
    end
  end

  def remove_at(idx)
    if idx === 0
      @head = fetch_node(1)
    end
    if idx === @size
      pop
    end
    idx<@size && idx>0? fetch_node(idx-1).next_node = fetch_node(idx+1):nil
  end

end
