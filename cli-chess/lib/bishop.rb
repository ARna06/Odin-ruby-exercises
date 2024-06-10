class Bishop

  NOTATION = ['♗', '♝']

  def initialize(location, color)
    @location = location
    if color == 'white'
      @symbol = NOTATION[0]
    else
      @symbol = NOTATION[1]
    end
    @move_number = 0
    @possible_moves = Array.new
  end

  attr_reader :symbol,:location

  def gen_possible_moves(board)
    @possible_moves = Array.new

    #north-east moves
    y_coord, x_coord = @location[0]-1, @location[1]+1
    while x_coord < 8 && y_coord >= 0 && board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
      x_coord += 1
      y_coord -= 1
    end
    if !board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
    end
    #south-east moves
    y_coord , x_coord = @location[0]+1, @location[1]+1
    while x_coord<8 && y_coord < 8 && board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
      x_coord += 1
      y_coord += 1
    end
    if !board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
    end
    #south-west moves
    y_coord , x_coord = @location[0]+1, @location[1]-1
    while x_coord>=0 && y_coord < 8 && board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
      x_coord -= 1
      y_coord += 1
    end
    if !board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
    end
    #north-west moves
    y_coord , x_coord = @location[0]-1, @location[1]-1
    while x_coord>=0 && y_coord >=0 && board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
      x_coord -= 1
      y_coord -= 1
    end
    if !board[y_coord][x_coord].nil?
      @possible_moves << [y_coord, x_coord]
    end
  end

  def move(to, board)
    gen_possible_moves(board)
    if @possible_moves.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    return false
  end
end
