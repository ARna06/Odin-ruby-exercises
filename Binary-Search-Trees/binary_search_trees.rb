class Tree_Node

  include Comparable

  def initialize(value , left_children = nil, right_children = nil)
    @value = value
    @left = left_children
    @right = right_children

  end

  attr_accessor :value, :left, :right

  def <=>(other_node)
    @value <=> other_node.value
  end
end


class Tree
  def initialize(arr)
    @array = arr
    @root = build_tree(@array)

  end

  def build_tree(arr)
    sorted = arr.uniq.sort
    mid = (sorted.length/2).floor
    if sorted.length === 1
      return Tree_Node.new(sorted[0])
    elsif sorted.length === 2
      return Tree_Node.new(sorted[mid], build_tree(sorted[0..mid-1]))
    else
      return Tree_Node.new(sorted[mid], build_tree(sorted[0..mid-1]), build_tree(sorted[mid+1..-1]))
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(element, node = @root)
    if @array.include?(element)
      return nil
    end
    new_node = Tree_Node.new(element)

    if node < new_node
      if node.right.nil?
        node.right = new_node
      else
        return insert(element, node = node.right)
      end
    else
      if node.left.nil?
        node.left = new_node
      else
        return insert(element, node = node.left)
      end
    end
  end

  def find(element, node = @root)

    if node.nil?
      return nil
    end
    if node.value === element
      return node
    end
    if node.value > element
      return find(element, node = node.left)
    else
      return find(element, node = node.right)
    end
  end

  def isLeaf?(node)
    return !node.value.nil? && node.right.nil? && node.left.nil?
  end

  def isIncomplete?(node)
    return !node.value.nil? && (node.right.nil? ^ node.left.nil?)
  end

  def delete_node(element,node = @root)
    if find(element).nil?
      return nil
    end

    if isLeaf?(find(element))

      if element<node.value
        if element === node.left.value
          node.left = nil
        else
          return delete_node(element, node = node.left)
        end
      else
        if element === node.right.value
          node.right = nil
        else
          return delete_node(element, node = node.right)
        end
      end

    elsif isIncomplete?(find(element))

      if element< node.value
        if element === node.left.value
          if node.left.left.nil?
            node.left = node.left.right
          else
            node.left = node.left.left
          end
        else
          return delete_node(element, node = node.left)
        end
      else
        if element === node.right.value
          if node.right.left.nil?
            node.right = node.right.right
          else
            node.right = node.right.left
          end
        else
          return delete_node(element, node = node.right)
        end
      end

    else
      inorder = inorder_traversal(node)
      inorder_successor = inorder[inorder.find_index(element)+1]

      delete_node(inorder_successor)
      replace(element, inorder_successor)

    end

  end

  def inorder_traversal(node = @root, array = [])
    if node.nil?
      return nil
    end

    inorder_traversal(node.left, array)
    array << node.value
    inorder_traversal(node.right, array)
    return array unless array.empty?
  end

  def preorder_traversal(node = @root, array = [])
    if node.nil?
      return nil
    end

    array << node.value
    preorder_traversal(node.left, array)
    preorder_traversal(node.right, array)
    return array unless array.empty?
  end

  def postorder_traversal(node = @root, array = [])
    if node.nil?
      return nil
    end

    postorder_traversal(node.left, array)
    postorder_traversal(node.right, array)
    array << node.value
    return array unless array.empty?
  end

  def replace(element,replacer, node = @root)
    if find(element).nil?
      return nil
    end
    if element === node.value
      node.value = replacer
    end
    if element < node.value
      if element === node.left.value
        node.left.value = replacer
      else
        replace(element,replacer, node = node.left)
      end
    else
      if element === node.right.value
        node.right.value = replacer
      else
        replace(element, replacer, node = node.right)
      end
    end
  end

  def levelorder_traversal(node = @root)
    return if node.nil?

    queue = Array.new
    arr = []
    queue << node
    while !queue.empty?
      current = queue[0]

      arr << current.value
      queue << current.left if !current.left.nil?
      queue << current.right if !current.right.nil?
      queue.shift
    end
    return arr
  end

  def depth(element, node = @root , depth = 0)
    return if find(element).nil?
    return depth if node.value === element
    depth += 1
    if element < node.value
      return depth(element, node.left, depth)
    else
      return depth(element, node.right, depth)
    end
  end

  def height_node(node = @root)
    return 0 if node.nil?
    return [height_node(node.left), height_node(node.right)].max + 1
  end

  def height(element)
    node = find(element)
    return height_node(node)-1
  end

  def balanced?(node = @root)
    return true if node.nil?
    left_height = height_node(node.left)
    right_height = height_node(node.right)
    if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
      return true
    end
    return false
  end

  def rebalance
    @root = build_tree(levelorder_traversal(@root))
  end

end
