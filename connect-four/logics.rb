class Game

  Num_Columns = 7
  Num_Rows = 6

  def initialize
    @board = Array.new(Num_Columns){Array.new(Num_Rows)}
    @turn = 0
    @symbols = ['🔵','🔴']
  end

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

  def win_checker

  end
end

test = Game.new
7.times do
  print "Enter your move: "
  move = gets.chomp.to_i
  test.get_moves(move)
end
