require './lib/board'
require './lib/logics'

print "This is a simple implementation of the game chess in a command line interface."
print "You can exit the game typing the word 'exit' .\n"

game = Board.new
game.make_board
temp = game.dup
until Win.win(temp)
  if !Win.checkmate(game.board, game.turn)
    print "Select the piece: "
    location = gets.chomp
    if location == 'exit'
      break
    end
    circumstances = game.move_options(location)
    if circumstances
      print "Decide your move: "
      to = gets.chomp
      game.make_move(location, to)
    end
  else
    print "The opponent has checkmate you!"
    print "Try to counter the checkmate.\n"
    puts "Select a piece :"
    location = gets.chomp
    if location == 'exit'
      break
    end
    circumstances = game.move_options(location)
    if circumstances
      print "Decide your move: "
      to = gets.chomp
      last_turn = game.turn - 1
      if Win.checkmate(board, last_turn)
        game.make_move(location, to)
      else
        print "Counter the checkmate."
        print "Insert a valid move! \n"
      end
    end
  end
  game.make_board
  temp = game.dup
end

win_color = game.turn%2 == 1? 'white':'black'
puts "#{win_color} has won the game!"
