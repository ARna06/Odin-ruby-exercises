class Knight

  NOTATION = ['♘', '♞']
  LEGAL_MOVES = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]

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

  def gen_possible_moves
    @possible_moves = Array.new
    LEGAL_MOVES.each do |locus|
      x_coor = locus[0] + @location[0]
      y_coor = locus[1] + @location[1]
      if [*0..7].include?(x_coor) && [*0..7].include?(y_coor)
        @possible_moves << [x_coor , y_coor]
      end
    end
  end

  def move(to, board)
    gen_possible_moves
    if @possible_moves.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    return false
  end
end