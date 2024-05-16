require_relative '../Linked-List/linked_list'

class Node_object
  def initialize(key,value)
    @key = key
    @value = value
  end
  attr_accessor :key, :value
end

class HashMap

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    return hash_code
  end

  LOAD_FACTOR = 0.75

  def initialize
    @size = 16
    @capacity = 0
    @bucket = Array.new
    @bucket_population = Array.new
  end

  attr_reader :size

  def clear
    @size = 16
    @capacity = 0
    @bucket = Array.new
    @bucket_population = Array.new
  end

  def set(key, val)
    hash_code = hash(key)
    index = hash_code % @size

    if @bucket_population.include?(index)
      bucket_index = @bucket_population.find_index(index)
      l_list = @bucket[bucket_index]
      i = 0
      node = l_list.fetch_node(i)
      until node.value.nil?
        if node.value.key === key
          node.value.value = val
          break
        end
        i += 1
        node = l_list.fetch_node(i)
      end
      if i === l_list.size
        l_list.append(Node_object.new(key, val))
        @capacity += 1
      end
    else
      @bucket_population.push(index)
      l_list = LinkedList.new
      @bucket.push(l_list)
      l_list.append(Node_object.new(key,val))
      @capacity += 1
    end
    grow
  end

  def grow
    load = @capacity/@size
    if load > LOAD_FACTOR
      duplicate = @bucket
      @size *= 2
      @bucket = Array.new
      @capacity = 0
      @bucket_population = Array.new
      duplicate.each do |bucket|
        i = 0
        while i<bucket.size
          key_value_pair = bucket.at(i)
          set(key_value_pair.key, key_value_pair.value)
          i += 1
        end
      end
    end
  end

  def get(key)
    index = hash(key) % @size
    bucket_index = @bucket_population.find_index(index)
    target_bucket = @bucket[bucket_index]
    i = 0
    while i < target_bucket.size
      if target_bucket.at(i).key === key
        value = target_bucket.at(i).value
        break
      end
      i += 1
    end
    if i === target_bucket.size
      return nil
    end
    return value
  end

  def has?(key)
    if get(key).nil?
      return false
    else
      return true
    end
  end

  def remove(key)
    if has?(key)
      index = hash(key) % @size
      bucket_index = @bucket_population.find_index(index)

      i = 0
      while i<@bucket[bucket_index].size
        if @bucket[bucket_index].at(i).key === key
          @bucket[bucket_index].remove_at(i)
          if @bucket[bucket_index].size === 0
            @bucket_population.delete(index)
            @bucket.delete(bucket_index)
          end
          break
        end
        i += 1
      end
    end
  end

  def keys
    list = Array.new
    @bucket.each do |bins|
      i = 0
      while i<bins.size
        key_val_pair = bins.at(i)
        list.push(key_val_pair.key)
        i += 1
      end
    end
    return list
  end

  def values
    list = Array.new
    @bucket.each do |bins|
      i = 0
      while i<bins.size
        key_val_pair = bins.at(i)
        list.push(key_val_pair.value)
        i += 1
      end
    end
    return list
  end

  def entries
    list = Array.new
    @bucket.each do |bins|
      i = 0
      while i<bins.size
        key_val_pair = bins.at(i)
        list.push([key_val_pair.key, key_val_pair.value])
        i += 1
      end
    end
    return list
  end

  def length
    return keys.length
  end

end
