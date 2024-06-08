# frozen_string_literal: true

require './lib/logics'

describe Game do
  describe '#horizontal' do
    it 'returns if there is any horizontal sequence of length 4 in the board' do
      test = Game.new
      blue_turn = 0
      until blue_turn == 4
        test.get_moves(blue_turn + 1)
        test.get_moves(7)
        blue_turn += 1
      end
      expect(test.win_checker).to eql(true)
    end
  end

  describe '#vertical' do
    it 'returns if there is a vertical match sequence of length 4' do
      test = Game.new
      red_turn = 0
      until red_turn == 4
        test.get_moves(1)
        test.get_moves(7 - red_turn)
        red_turn += 1
      end
      expect(test.win_checker).to eql(true)
    end
  end

  describe '#diagonal' do
    it 'returns if there is a diagonal match sequence' do
      test = Game.new
      val = 0
      until val == 4
        test.board[val][val] = 'X'
        val += 1
      end
      expect(test.win_checker).to eql(true)
    end
  end
end
