require_relative 'pawns'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
class Board
  def initialize
    @board = Array.new(8) {Array.new(8)}
    create_pawns
    create_knights
    create_rooks
    create_bishops
    create_queen
    create_king
  end

  def testing
    @board = Array.new(8) {Array.new(8)}
  end

  attr_accessor :board

  def create_pawns
    @board[1] = @board[1].map.with_index {|item, index| item = Pawns.new([1,index],'black')}
    @board[6] = @board[6].map.with_index {|item, index| item = Pawns.new([6,index],'white')}
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

  def make_board
    @board.each do |row|
      row.each do |element|
        if element.nil?
          print 'X'
        else
          print element.symbol
        end
      end
      print "\n"

    end
  end

  def make_move(location, to)
    location = location.split('')
    location.map! { |e| e = e.to_i }
    #print location
    return if location.length != 2
    return if location.any?{|e| e>7 || e <0}
    item = @board[location[0]][location[1]]
    #p item

    return if item.nil?
    to = to.split('')
    to.map! { |e| e.to_i }
    #print to
    return if to.length != 2
    return if to.any? {|e| e>7 || e<0 }
    truthy = item.move(to, @board)
    if truthy
      @board[location[0]][location[1]] = nil
      @board[to[0]][to[1]] = item
      #print true
    else
      #print false
      return nil
    end
  end
end

test = Board.new
test.make_board

3.times do
  print "Select the piece: "
  location = gets.chomp
  print "Decide your move: "
  to = gets.chomp
  test.make_move(location, to)
  test.make_board
end
