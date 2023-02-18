require 'spec_helper'

RSpec.describe Game do
  describe '#initialize' do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
    end
  end
end