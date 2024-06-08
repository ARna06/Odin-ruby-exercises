# frozen_string_literal: true

class Game
  NUM_COLUMNS = 7
  NUM_ROWS = 6

  def initialize
    @board = Array.new(NUM_COLUMNS) { Array.new(NUM_ROWS) }
    @turn = 0
    @symbols = ['🔵', '🔴']
  end

  attr_reader :turn
  attr_accessor :board

  def board_status(move, location)
    required_column = @board[location - 1]
    idx = required_column.index(nil)
    required_column[idx] = move
    @turn += 1
  end

  def get_moves(column_number)
    if column_number < 1 || column_number > 7
      puts 'Enter a valid location!'
    elsif @turn.even?
      board_status(@symbols[0], column_number)
    else
      board_status(@symbols[1], column_number)
    end
  end

  def make_board
    real_board = @board.dup
    real_board.map!(&:reverse)
    row_number = 0
    until row_number == NUM_ROWS
      real_board.each do |column|
        element = column[row_number]
        if element.nil?
          print '🟨'
        else
          print element
        end
      end
      print "\n"
      row_number += 1
    end
  end

  def matching(ele1, ele2, ele3, ele4)
    !ele1.nil? && !ele2.nil? && !ele3.nil? && !ele4.nil? && ele1 == ele2 && ele2 == ele3 && ele3 == ele4
  end

  def win_checker
    checker = []
    # check vertical matches
    @board.each do |columns|
      (0..2).each do |i|
        checker << matching(columns[i], columns[i + 1], columns[i + 2], columns[i + 3])
      end
    end
    # check horizontal matches
    (0..5).each do |i|
      (0..2).each do |j|
        checker << matching(@board[j][i], @board[j + 1][i], @board[j + 2][i], @board[j + 3][i])
      end
    end
    # check diagonal matches
    (0..3).each do |i|
      (0..2).each do |j|
        checker << matching(@board[i][j], @board[i + 1][j + 1], @board[i + 2][j + 2], @board[i + 3][j + 3])
        checker << matching(@board[i + 3][j], @board[i + 2][j + 1], @board[i + 1][j + 2], @board[i][j + 3])
      end
    end

    checker.any?(true)
  end
end
