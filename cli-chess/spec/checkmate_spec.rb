# frozen_string_literal: true

require './lib/logics'
require './lib/board'

describe 'Checkmate possibilities statisfied' do
  describe '#checkmate with a queen' do
    test = Board.new
    test.testing
    it 'returns if it can be checkmate with a queen 1' do
      test.board[0][0] = King.new([0, 0], 'white')
      test.board[0][7] = Queen.new([0, 7], 'black')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(true)
    end

    it 'returns if it can be checkmate with a queen 2' do
      test.testing
      test.board[0][0] = King.new([0, 0], 'white')
      test.board[1][2] = Queen.new([1, 2], 'black')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(false)
    end

    it 'returns if it can be checkmate with a queen 3' do
      test.testing
      test.board[0][0] = King.new([0, 0], 'white')
      test.board[2][2] = Queen.new([2, 2], 'black')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(true)
    end

    it 'returns if it can be checkmate with a queen 4' do
      test.testing
      test.board[0][0] = King.new([0, 0], 'white')
      test.board[1][1] = Knight.new([1, 1], 'white')
      test.board[2][2] = Queen.new([1, 2], 'black')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(false)
    end
  end

  describe '#checkmate with a pawn' do
    test = Board.new
    test.testing
    it 'returns if king can be checkmate with a pawn 1' do
      test.board[1][1] = Pawn.new([1, 1], 'black')
      test.board[2][0] = King.new([2, 0], 'white')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(true)
    end

    it 'returns if king can be checkmate with a pawn 2' do
      test.board[1][1] = Pawn.new([1, 1], 'black')
      test.board[2][1] = King.new([2, 1], 'white')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(false)
    end
  end

  describe '#checkmate with a knight' do
    test = Board.new
    test.testing
    it 'returns if it can be checkmate with a knight' do
      test.board[0][0] = King.new([0, 0], 'white')
      test.board[1][2] = Knight.new([1, 2], 'black')
      test.turn = 2
      test.updater
      expect(Win.checkmate(test.board, test.turn)).to be(true)
    end
  end
end

describe 'Checkmate removal if possible' do
  test = Board.new
  test.testing
  it '#returns if the checkmate condition is removable by moving a piece' do
    test.board[0][0] = King.new([0, 0], 'white')
    test.board[0][1] = Queen.new([0, 1], 'white')
    test.board[1][0] = Rook.new([1, 0], 'white')
    test.board[2][2] = Queen.new([2, 2], 'black')
    test.turn = 4
    test.updater
    expect(Win.check_removable(test)[0]).to be(true)
  end

  it '#returns if the checkmate can be invalidated by capturing a piece' do
    test = Board.new
    test.testing
    test.board[0][2] = King.new([0, 2], 'white')
    test.board[0][0] = Queen.new([0, 0], 'black')
    test.board[3][0] = Rook.new([3, 0], 'white')
    test.turn = 4
    test.updater
    expect(Win.check_removable(test)[0]).to be(true)
  end

  it 'returns if the checkmate cannot be invalidated resulting in a win' do
    test = Board.new
    test.testing
    test.board[0][0] = King.new([0, 0], 'white')
    test.board[0][1] = Pawn.new([0, 1], 'white')
    test.board[1][1] = Pawn.new([1, 1], 'white')
    test.board[4][0] = Queen.new([4, 0], 'black')
    test.turn = 4
    test.updater
    expect(Win.check_removable(test)[0]).to be(false)
  end
end
