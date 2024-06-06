class Vertex

  LEGAL_MOVES = [[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2],[1,2]]

  def initialize(value)
    @value = value
    @children = Array.new
  end

  def addChildren
    x_coord , y_coord = @value[0], @value[1]
    for moves in LEGAL_MOVES
      if (x_coord + moves[0] in 0...8) && (y_coord + moves[1] in 0...8)
        @children.push(Vertex.new([x_coord+moves[0], y_coord+moves[1]]))
      end
    end
  end

  def childrenValues
    values = Array.new
    @children.each do |child|
      values << child.value
    end
    return values
  end

  attr_accessor :value, :children

end

class Trie
  def initialize(origin, sink)
    @origin = origin
    @root = Vertex.new(origin)
    @sink = sink
  end

  def path
    cloud = Array.new
    cloud << @root
    idx = 0
    current_vertex = cloud[idx]
    current_vertex.addChildren
    until current_vertex.childrenValues.include?(@sink)
      current_vertex.children.each do |child|
        cloud << child
      end
      idx += 1
      current_vertex = cloud[idx]
      current_vertex.addChildren
    end
    cloud << current_vertex

    reverse_path = Array.new
    reverse_path << @sink
    current = cloud.pop.value
    reverse_path << current
    until current === @origin
      cloud.each do |vertex|
        if vertex.childrenValues.include?(current)
          current = vertex
        end
      end
      cloud.delete(current)
      current = current.value
      reverse_path << current
    end
    return reverse_path.reverse
  end
end

def knight_travail(source, sink)
  tree = Trie.new(source, sink)
  path = tree.path
  puts "You can reach from #{source} to #{sink} in #{path.length-1} moves."
  puts "The path is given by #{path}"
end

knight_travail([0,0], [7,7])
