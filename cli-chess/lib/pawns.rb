require_relative 'helper'
require_relative 'logics'
class Pawn

  NOTATION = ['♙', '♟']

  include Helpers
  include Pawn_specials

  def initialize(location, color)
    @location = location
    @color = color
    if @color == 'white'
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
    if @symbol == '♙'
      if @move_number == 0
        @possible_moves << [@location[0]-2,@location[1]]
      end
      @possible_moves << [@location[0]-1,@location[1]]
    else
      if @move_number == 0
        @possible_moves << [@location[0]+2,@location[1]]
      end
      @possible_moves << [@location[0]+1,@location[1]]
    end
  end

  def update(board)
    gen_possible_moves
    @attacks = Pawn_specials.attacks(@location, board, @color)
    @possible_moves.select!{|to| board[to[0]][to[1]].nil?}
    @possible_moves = Helpers.clear_possible_moves(@possible_moves, board, @color)
  end

  def move(to)
    if @possible_moves.include?(to) || @attacks.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    return false
  end
end
