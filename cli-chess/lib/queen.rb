class Queen

  NOTATION = ['♕', '♛']

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

    n_coord = @location[0] - 1
    while n_coord >= 0 && board[n_coord][@location[1]].nil?
      @possible_moves << [n_coord, @location[1]]
      n_coord -= 1
    end
    if n_coord >= 0
      @possible_moves << [n_coord,@location[1]]
    end
    s_coord = @location[0] + 1
    while s_coord < 8 && board[s_coord][@location[1]].nil?
      @possible_moves << [s_coord, @location[1]]
      s_coord += 1
    end
    if s_coord < 8
      @possible_moves << [s_coord, @location[1]]
    end
    e_coord = @location[1] + 1
    while e_coord < 8 && board[@location[0]][e_coord].nil?
      @possible_moves << [@location[0], e_coord]
      e_coord += 1
    end
    if e_coord < 8
      @possible_moves << [@location[0], e_coord]
    end
    w_coord = @location[1] - 1
    while w_coord >=0 && board[@location[0]][w_coord].nil?
      @possible_moves << [@location[0], w_coord]
      w_coord -= 1
    end
    if w_coord >= 0
      @possible_moves << [@location[0], w_coord]
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
