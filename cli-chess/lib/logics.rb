# frozen_string_literal: true

require_relative 'board'
module Pawn_specials
  POSSIBLE_ATTACKS_WHITE = [[-1, -1], [-1, 1]].freeze
  POSSIBLE_ATTACKS_BLACK = [[1, 1], [1, -1]].freeze

  def self.attacks(location, board, color)
    moves = []
    if color == 'white'
      POSSIBLE_ATTACKS_WHITE.each do |movements|
        final_y = location[0] + movements[0]
        final_x = location[1] + movements[1]
        next unless [*0..7].include?(final_x) && [*0..7].include?(final_y)

        temp = board[final_y][final_x]
        moves << [final_y, final_x] if !temp.nil? && temp.color != color
      end
    else
      POSSIBLE_ATTACKS_BLACK.each do |movements|
        final_y = location[0] + movements[0]
        final_x = location[1] + movements[1]
        next unless [*0..7].include?(final_x) && [*0..7].include?(final_y)

        temp = board[final_y][final_x]
        moves << [final_y, final_x] if !temp.nil? && temp.color != color
      end
    end
    moves
  end
end

module Win
  def self.checkmate(board, turn)
    # if turn is odd then it was white's turn else it was black's turn
    prev_color = turn.odd? ? 'white' : 'black'
    collector = []
    curr_king = nil
    board.each do |row|
      row.each do |element|
        curr_king = element if element.instance_of?(King) && element.color != prev_color
        collector << element if !element.nil? && element.color == prev_color
      end
    end
    collector.any? { |piece| piece.attacks.include?(curr_king.location) }
  end

  def self.check_removable(game)
    # temp = game.dup

    temp = Board.new
    temp.testing
    temp.board = game.board.dup.map(&:dup)
    temp.turn = game.turn.dup
    turn = temp.turn
    board = temp.board

    curr_color = turn.even? ? 'white' : 'black'
    remaining_pieces = []
    allowable_moves = {}

    board.each do |row|
      row.each do |piece|
        allowable_moves[piece.class.to_s] = [] unless piece.nil?

        remaining_pieces << piece if !piece.nil? && piece.color == curr_color
      end
    end
    remaining_moves = []
    restrictions = []
    remaining_pieces.each do |piece|
      location = piece.location
      possible_moves = piece.attacks + piece.possible_moves
      possible_moves.uniq!
      possible_moves.each do |moves|
        temp.updater
        piece.location = moves
        board[location[0]][location[1]] = nil
        board[moves[0]][moves[1]] = piece
        temp.board = board
        temp.updater

        unless checkmate(temp.board, temp.turn)
          remaining_moves << piece.class
          restrictions << moves
          allowable_moves[piece.class.to_s] << moves
        end

        piece.location = location
        board[location[0]][location[1]] = piece
        board[moves[0]][moves[1]] = nil
        temp.board = board
        temp.updater
      end
    end
    [!remaining_moves.empty?, allowable_moves, restrictions]
  end
end
