require 'spec_helper'

RSpec.describe Game do
  describe '#initialize' do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
    end

    it 'has welcome message' do
      game = Game.new

      expect(game.start).to eq('Welcome to BATTLESHIP\nEnter p to play. Enter q to quit')
    end
  end

  describe '#setup' do
    it 'creates cpu ships and board' do
      game = Game.new

      expect(@cpu_board).to be_a(Board)
      expect(@cpu_submarine).to be_a(Ship)
      expect(@cpu_cruiser).to be_a(Ship)
    end
  

    it 'creates player ships and board' do
      game = Game.new

      expect(@player_board).to be_a(Board)
      expect(@player_cruiser).to be_a(Ship)
      expect(@player_submarine).to be_a(Ship)
    end
  end
end