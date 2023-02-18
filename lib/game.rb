class Game
  attr_reader :cpu_board,
              :cpu_submarine,
              :cpu_cruiser,
              :player_board,
              :player_submarine,
              :player_cruiser

  def initialize
    @cpu_board = nil
    @cpu_submarine = nil
    @cpu_cruiser = nil
    @player_board = nil
    @player_submarine = nil
    @player_cruiser = nil
  end

  def start
    welcome = "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit"
    p welcome
  #   input = gets.chomp
  #   if input.upcase == 'P'
  #     game.setup_game
  #   else p "Until next time..."
  # end
  end

  def setup_game
    @cpu_board = Board.new
    @player_board = Board.new
    @cpu_submarine = Ship.new('Submarine', 2)
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
  end

  def cpu_setup
    cpu_cruiser_placement = @cpu_board.valid_cruiser_placements.sample
    @cpu_board.place(@cpu_cruiser, cpu_cruiser_placement)
    cpu_sub_placement = @cpu_board.valid_submarine_placements.sample
    @cpu_board.place(@cpu_submarine, cpu_sub_placement)
  end

  def player_setup
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The cruiser is 3 units long and the submarine is 2 units long.'
    print "#{@player_board.render}"
  end
end