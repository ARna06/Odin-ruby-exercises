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

module Win
  def self.checkmate(board, turn)
    #if turn is odd then it was white's turn else it was black's turn
    prev_color = turn%2 == 1? 'white':'black'
    collector = Array.new
    curr_king = nil
    board.each do |row|
      row.each do |element|
        curr_king = element if element.class == King && element.color != prev_color
        if !element.nil? && element.color == prev_color
          collector << element
        end
      end
    end
    return collector.any? {|piece| piece.attacks.include?(curr_king.location)}
  end

  def self.win(game)
    board = game.board
    turn = game.turn
    prev_color = turn%2 == 1? 'white':'black'
    all_possible_moves = Array.new
    own_piece_collector = Array.new
    board.each do |row|
      row.each do |element|
        if !element.nil? && element.color != prev_color
          own_piece_collector << element
        end
      end
    end
    own_piece_collector.each do |piece|
      all_legal_moves = piece.possible_moves + piece.attacks
      all_legal_moves.uniq!
      all_legal_moves.each do |locus|
        board[piece.location[0]][piece.location[1]] = nil
        board[locus[0]][locus[1]] = piece
        piece.move(locus)
        game.board = board
        game.updater
        if !self.checkmate(game.board, turn)
          all_possible_moves << locus
        end
      end
    end
    return all_possible_moves.empty?
  end
end
