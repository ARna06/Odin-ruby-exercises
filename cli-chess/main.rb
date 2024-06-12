require './lib/board'

test = Board.new
test.make_board

3.times do
  print "Select the piece: "
  location = gets.chomp
  circumstances = test.move_options(location)
  if circumstances
    print "Decide your move: "
    to = gets.chomp
    test.make_move(location, to)
  end
  test.make_board
end
