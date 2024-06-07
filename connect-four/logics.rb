class Game

  Num_Columns = 7
  Num_Rows = 6

  def initialize
    @board = Array.new(Num_Columns){Array.new(Num_Rows)}
    @turn = 0
    @symbols = ['🔵','🔴']
  end

  attr_reader :turn

  def board_status(move, location)
    required_column = @board[location-1]
    idx = required_column.index(nil)
    required_column[idx] = move
    @turn += 1
  end

  def get_moves(column_number)
    if column_number < 1 || column_number > 7
      puts "Enter a valid location!"
    else
      if @turn.even?
        board_status(@symbols[0], column_number)
        make_board
      else
        board_status(@symbols[1], column_number)
        make_board
      end
    end
  end

  def make_board
    real_board = @board.dup
    real_board.map! do |column|
      column.reverse
    end
    row_number = 0
    until row_number === Num_Rows
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

  def matching(e1, e2, e3, e4)
    return !e1.nil? && !e2.nil? && !e3.nil? && !e4.nil? && e1 === e2 && e2 === e3 && e3 === e4
  end

  def win_checker
    checker = Array.new
    #check vertical matches
    @board.each do |columns|
      for i in 0..2
        checker << matching(columns[i],columns[i+1],columns[i+2],columns[i+3])
      end
    end
    #check horizontal matches
    for i in 0..5
      for j in 0..2
        checker << matching(@board[j][i], @board[j+1][i], @board[j+2][i], @board[j+3][i])
      end
    end
    #check diagonal matches
    for i in 0..3
      for j in 0..2
        checker << matching(@board[i][j], @board[i+1][j+1], @board[i+2][j+2], @board[i+3][j+3])
        checker << matching(@board[i+3][j],@board[i+2][j+1], @board[i+1][j+2], @board[i][j+3])
      end
    end

    return checker.any?(true)
  end
end
