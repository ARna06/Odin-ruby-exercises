require_relative 'pawns'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'helper'
class Board

  include Helpers

  def initialize
    @board = Array.new(8) {Array.new(8)}
    create_pawns
    create_knights
    create_rooks
    create_bishops
    create_queen
    create_king
    updater
    @turn = 0
  end

  def testing
    @board = Array.new(8) {Array.new(8)}
  end

  attr_accessor :board, :turn

  def create_pawns
    @board[1] = @board[1].map.with_index {|item, index| item = Pawn.new([1,index],'black')}
    @board[6] = @board[6].map.with_index {|item, index| item = Pawn.new([6,index],'white')}
  end

  def create_knights
    @board[0][1] = Knight.new([0,1],'black')
    @board[0][6] = Knight.new([0,6],'black')
    @board[7][1] = Knight.new([7,1],'white')
    @board[7][6] = Knight.new([7,6],'white')
  end

  def create_rooks
    @board[0][0] = Rook.new([0,0], 'black')
    @board[0][7] = Rook.new([0,7], 'black')
    @board[7][0] = Rook.new([7,0], 'white')
    @board[7][7] = Rook.new([7,7], 'white')
  end

  def create_bishops
    @board[0][2] = Bishop.new([0,2],'black')
    @board[0][5] = Bishop.new([0,5],'black')
    @board[7][2] = Bishop.new([7,2],'white')
    @board[7][5] = Bishop.new([7,5],'white')
  end

  def create_queen
    @board[0][3] = Queen.new([0,3],'black')
    @board[7][3] = Queen.new([7,3],'white')
  end

  def create_king
    @board[0][4] = King.new([0,4],'black')
    @board[7][4] = King.new([7,4],'white')
  end

  def updater
    @board.each do |rows|
      rows.each do |element|
        if !element.nil?
          element.update(@board)
        end
      end
    end
  end

  def make_board
    temp = @board.dup
    if !@turn.even?
      temp.reverse!
    end
    temp.each do |row|
      row.each do |element|
        if element.nil?
          print 'X'
        else
          print element.symbol
        end
      end
      print "\n"
    end
    expected_color = @turn%2 == 0?'white':'black'
    puts "Turn for #{expected_color}"
  end

  def move_options(input)
    updater
    location = IO_handler.input(input, @board)
    return if location.nil?
    item = @board[location[0]][location[1]]
    expected_color = @turn%2 == 0?'white':'black'
    return puts "Choose your pieces only!" if item.color != expected_color
    print "You've selected a #{item.class}\n"
    print "The possible moves are: "
    item.possible_moves.each { |locus| print "#{IO_handler.output(locus)}, " }
    print "\n"
    if !item.attacks.empty?
      print "Attacks can be done at: \n"
      item.attacks.each { |locus| print "#{IO_handler.output(locus)} : #{@board[locus[0]][locus[1]].class}\n" }
    end
    return true
  end

  def make_move(location, to)
    location = IO_handler.input(location, @board)
    to = IO_handler.destination(to)
    return if location.nil?
    return if to.nil?
    item = @board[location[0]][location[1]]
    expected_color = @turn%2 == 0?'white':'black'
    return if item.color != expected_color
    truthy = item.move(to)
    if truthy
      @board[location[0]][location[1]] = nil
      @board[to[0]][to[1]] = item
      @turn += 1
    else
      print "Illegal move!\n"
    end
  end
end
