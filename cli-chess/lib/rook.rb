# frozen_string_literal: true

require_relative 'helper'
class Rook
  include Helpers
  include Rook_behavior

  NOTATION = ['♖', '♜'].freeze

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = if color == 'white'
                NOTATION[0]
              else
                NOTATION[1]
              end
    @move_number = 0
    @possible_moves = []
    @attacks = []
  end

  attr_reader :symbol, :attacks, :possible_moves, :color
  attr_accessor :location

  def update(board)
    @possible_moves = Rook_behavior.rook_moves(@location, board, @color)
    @attacks = Helpers.attacking_positions(@possible_moves, board, @color)
    @possible_moves = Helpers.clear_possible_moves(@possible_moves, board, @color)
  end

  def move(to)
    if @possible_moves.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    false
  end
end
