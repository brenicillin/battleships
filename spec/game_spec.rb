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
end