class Pawns

  NOTATION = ['♙', '♟']

  def initialize(location, color)
    @location = location
    if color == 'white'
      @symbol = NOTATION[0]
    else
      @symbol = NOTATION[1]
    end
    @move_number = 0
  end

  attr_reader :symbol,:location

  def move(to)
    if @move_number == 0 && (@location[0] - 1 == to[0] || @location[0] - 2 == to[0]) && @symbol == '♙'
      @location[0] = to[0]
      @move_number += 1
      return true
    end
    if @move_number != 0 && @location[0] - 1 == to[0] && @symbol == '♙'
      @location[0] = to[0]
      @move_number += 1
      return true
    end
    if @move_number == 0 && (@location[0] + 1 == to[0] || @location[0] + 2 == to[0]) && @symbol == '♟'
      @location[0] = to[0]
      @move_number += 1
      return true
    end
    if @move_number != 0 && @location[0] + 1 == to[0] && @symbol == '♟'
      @location = to[0]
      @move_number += 1
      return true
    end
    return false
  end
end
