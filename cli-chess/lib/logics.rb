module Pawn_specials

  POSSIBLE_ATTACKS_WHITE = [[-1,-1],[-1,1]]
  POSSIBLE_ATTACKS_BLACK = [[1,1],[1,-1]]

  def self.attacks(location, board, color)
    moves = Array.new
    if color == 'white'
      POSSIBLE_ATTACKS_WHITE.each do |movements|
        final_y = location[0]+ movements[0]
        final_x = location[1]+ movements[1]
        if [*0..7].include?(final_x) && [*0..7].include?(final_y)
          temp = board[final_y][final_x]
          if !temp.nil? && temp.color != color
            moves << [final_y, final_x]
          end
        end
      end
    else
      POSSIBLE_ATTACKS_BLACK.each do |movements|
        final_y = location[0]+ movements[0]
        final_x = location[1]+ movements[1]
        if [*0..7].include?(final_x) && [*0..7].include?(final_y)
          temp = board[final_y][final_x]
          if !temp.nil? && temp.color != color
            moves << [final_y, final_x]
          end
        end
      end
    end
    return moves
  end
end
