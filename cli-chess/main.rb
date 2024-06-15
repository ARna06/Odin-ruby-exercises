# frozen_string_literal: true

require './lib/board'
require './lib/logics'
require './lib/helper'
require './src/src'

print 'This is a simple implementation of the game chess in a command line interface.'
print "You can exit the game typing the word 'exit' .\n"
print "You can save the current instance of the game typing the word 'save'.\n"
print "You can load a previous instance of the game typing the word 'reload'.\n\n"

game = Board.new
game.make_board
while Win.check_removable(game)[0]
  if Win.checkmate(game.board, game.turn)
    print 'The opponent has checkmate you!'
    print "Try to counter the checkmate.\n"
    print "You can do the following possible moves: \n"
    possible_moves = Win.check_removable(game)[1]
    possible_moves.each do |piece, array|
      unless array.empty?
        print "#{piece} : "
        array.each do |move|
          print "#{IO_handler.output(move)}, "
        end
        print "\n"
      end
      print "\n"
    end
    puts 'Select a piece :'
    location = gets.chomp
    break if location == 'exit'

    Src.save(game) if location == 'save'
    if location == 'reload'
      file = File.read('saves/serialization.yaml')
      game = Src.reload(file)
      next
    end
    restrictions = Win.check_removable(game)[2]
    circumstances = game.move_options(location)
    if circumstances
      print 'Decide your move: '
      to = gets.chomp
      location_to = IO_handler.destination(to)
      if restrictions.include?(location_to)
        game.make_move(location, to)
      else
        print 'Counter the checkmate.'
        print "Insert a valid move! \n"
      end
    end
  else
    print 'Select the piece: '
    location = gets.chomp
    break if location == 'exit'

    if location == 'save'
      Src.save(game)
      break
    end
    if location == 'reload'
      file = File.read('saves/serialization.yaml')
      game.reload(file)
      next
    end
    circumstances = game.move_options(location)
    if circumstances
      print 'Decide your move: '
      to = gets.chomp
      game.make_move(location, to)
    end
  end
  game.make_board
  print "\n"
end

puts 'The game has been exited successfully!' if location == 'exit'

puts 'the game has been saved successfully!' if location == 'save'

if location != 'exit' && location != 'save'
  win_color = game.turn.odd? ? 'white' : 'black'
  puts "#{win_color} has won the game!"
end
