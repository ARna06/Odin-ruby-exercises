# frozen_string_literal: true

require 'yaml'

module Src
  def self.save(game)
    FileUtils.mkdir_p('src')
    all_pieces = []
    board = game.board
    board.each do |rows|
      rows.each do |element|
        next if element.nil?

        hash = {
          class: element.class.to_s,
          location: element.location,
          color: element.color
        }
        all_pieces << hash
      end
    end

    req = {
      all: all_pieces,
      turn: game.turn
    }

    File.open('saves/serialization.yaml', 'w') do |file|
      file.puts YAML.dump(req)
    end
  end
end
