# frozen_string_literal: true

module Helpers
  def self.attacking_positions(possible_moves, board, color)
    attacks = []
    possible_moves.each do |locus|
      attacks << locus if !board[locus[0]][locus[1]].nil? && board[locus[0]][locus[1]].color != color
    end
    attacks
  end

  def self.clear_possible_moves(possible_moves, board, color)
    possible_moves.select { |locus| board[locus[0]][locus[1]].nil? || board[locus[0]][locus[1]].color != color }
  end
end

module Bishop_behavior
  def self.bishop_moves(location, board)
    possible_moves = []

    # north-east moves
    y_coord = location[0] - 1
    x_coord = location[1] + 1
    while x_coord < 8 && y_coord >= 0 && board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
      x_coord += 1
      y_coord -= 1
    end
    if [*0..7].include?(x_coord) && [*0..7].include?(y_coord) && !board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
    end
    # south-east moves
    y_coord = location[0] + 1
    x_coord = location[1] + 1
    while x_coord < 8 && y_coord < 8 && board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
      x_coord += 1
      y_coord += 1
    end
    if [*0..7].include?(x_coord) && [*0..7].include?(y_coord) && !board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
    end
    # south-west moves
    y_coord = location[0] + 1
    x_coord = location[1] - 1
    while x_coord >= 0 && y_coord < 8 && board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
      x_coord -= 1
      y_coord += 1
    end
    if [*0..7].include?(x_coord) && [*0..7].include?(y_coord) && !board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
    end
    # north-west moves
    y_coord = location[0] - 1
    x_coord = location[1] - 1
    while x_coord >= 0 && y_coord >= 0 && board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
      x_coord -= 1
      y_coord -= 1
    end
    if [*0..7].include?(x_coord) && [*0..7].include?(y_coord) && !board[y_coord][x_coord].nil?
      possible_moves << [y_coord, x_coord]
    end
    possible_moves
  end
end

module Rook_behavior
  def self.rook_moves(location, board, color)
    possible_moves = []
    n_coord = location[0] - 1
    while n_coord >= 0 && board[n_coord][location[1]].nil?
      possible_moves << [n_coord, location[1]]
      n_coord -= 1
    end
    if [*0..7].include?(n_coord) && !board[n_coord][location[1]].nil? && board[n_coord][location[1]].color != color
      possible_moves << [n_coord, location[1]]
    end
    s_coord = location[0] + 1
    while s_coord < 8 && board[s_coord][location[1]].nil?
      possible_moves << [s_coord, location[1]]
      s_coord += 1
    end
    if [*0..7].include?(s_coord) && !board[s_coord][location[1]].nil? && board[s_coord][location[1]].color != color
      possible_moves << [s_coord, location[1]]
    end
    e_coord = location[1] + 1
    while e_coord < 8 && board[location[0]][e_coord].nil?
      possible_moves << [location[0], e_coord]
      e_coord += 1
    end
    if [*0..7].include?(e_coord) && !board[location[0]][e_coord].nil? && board[location[0]][e_coord].color != color
      possible_moves << [location[0], e_coord]
    end
    w_coord = location[1] - 1
    while w_coord >= 0 && board[location[0]][w_coord].nil?
      possible_moves << [location[0], w_coord]
      w_coord -= 1
    end
    if [*0..7].include?(w_coord) && !board[location[0]][w_coord].nil? && board[location[0]][w_coord].color != color
      possible_moves << [location[0], w_coord]
    end
    possible_moves
  end
end

module IO_handler
  def self.input(input, board)
    input = input.chars
    return nil if input.length != 2

    if [*'a'..'h'].include?(input[0]) && [*1..8].include?(input[1].to_i)
      location = [8 - input[1].to_i, input[0].ord - 97]
      if board[location[0]][location[1]].nil?
        print "The is no piece there!\n"
        return nil
      end
      return location
    end
    print "Enter a valid location!\n"
    nil
  end

  def self.output(location)
    [(location[1] + 97).chr, (8 - location[0]).to_s].join
  end

  def self.destination(input)
    input = input.chars
    return nil if input.length != 2

    if [*'a'..'h'].include?(input[0]) && [*1..8].include?(input[1].to_i)
      location = [8 - input[1].to_i, input[0].ord - 97]
      return location
    end
    print "Enter a valid location!\n"
  end
end
