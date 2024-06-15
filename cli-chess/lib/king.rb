# frozen_string_literal: true

require_relative 'helper'
class King
  include Helpers

  NOTATION = ['♔', '♚'].freeze
  LEGAL_MOVES = [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]].freeze

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

  def gen_possible_moves
    @possible_moves = []
    LEGAL_MOVES.each do |locus|
      x_coor = locus[0] + @location[0]
      y_coor = locus[1] + @location[1]
      @possible_moves << [x_coor, y_coor] if [*0..7].include?(x_coor) && [*0..7].include?(y_coor)
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
    false
  end
end
