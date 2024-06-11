require_relative 'helper'
class Knight

  include Helpers

  NOTATION = ['♘', '♞']
  LEGAL_MOVES = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]

  def initialize(location, color)
    @location = location
    @color = color
    if color == 'white'
      @symbol = NOTATION[0]
    else
      @symbol = NOTATION[1]
    end
    @move_number = 0
    @possible_moves = Array.new
    @attacks = Array.new
  end

  attr_reader :symbol, :location, :attacks, :possible_moves, :color

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

  def update(board)
    gen_possible_moves
    @attacks = Helpers.attacking_positions(@possible_moves, board, @color)
    @possible_moves = Helpers.clear_possible_moves(@possible_moves, board, @color)
  end

  def move(to)
    if @possible_moves.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    return false
  end
end
