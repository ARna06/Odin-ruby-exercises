require_relative 'helper'
class Rook

  include Helpers
  include Rook_behavior

  NOTATION = ['♖', '♜']

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

  def update(board)
    @possible_moves = Rook_behavior.rook_moves(@location, board)
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
