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
    print welcome
    input = gets.chomp
    if input.upcase == 'P'
      play
    else p "Until next time..."
    end
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
      while @cpu_board.valid_placement?(@cpu_submarine, cpu_sub_placement) == false
      cpu_sub_placement = @cpu_board.valid_submarine_placements.sample
      end
      @cpu_board.place(@cpu_submarine, cpu_sub_placement)
    end
    
  def player_setup
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The cruiser is 3 units long and the submarine is 2 units long.'
    puts @player_board.render(true)
    
    puts "Enter cruiser coordinates ex: A1 A2 A3 :"
    player_cruiser_coordinates = []
    puts "#{player_cruiser_coordinates << gets.chomp.upcase.split}"
    while @player_board.valid_placement?(@player_cruiser, player_cruiser_coordinates[0]) == false
      puts "Those are invalid coordinates. Try again."
      player_cruiser_coordinates = []
      puts "#{player_cruiser_coordinates << gets.chomp.upcase.split}"
    end
    @player_board.place(@player_cruiser, player_cruiser_coordinates[0])
    
    puts @player_board.render(true)
    
    puts "Enter submarine coordinates ex: B2 C2 :"
    player_submarine_coordinates = []
    puts "#{player_submarine_coordinates << gets.chomp.upcase.split}"
    while @player_board.valid_placement?(@player_submarine, player_submarine_coordinates[0]) == false
      puts "Those are invalid coordinates. Try again."
      player_submarine_coordinates = []
      puts "#{player_submarine_coordinates << gets.chomp.upcase.split}"
    end
    @player_board.place(@player_submarine, player_submarine_coordinates[0])
    
    print @player_board.render(true)
  end
  
  def display_boards
    puts " "
    puts "==========COMPUTER BOARD=========="
    puts @cpu_board.render
    puts "===========PLAYER BOARD==========="
    puts @player_board.render(true) #ask about writing this test
  end
  
  def player_shot
    puts "Where do you want to shoot?"
      target = gets.chomp.upcase
      while @cpu_board.valid_coordinate?(target) == false
        puts "Please select a target coordinate on the board"
        target = gets.chomp.upcase
      end
      while @cpu_board.cells[target].fired_upon? == true
        puts "You have aleady fired upon that coordinate"
        gets.chomp.upcase
      end
      @cpu_board.cells[target].fire_upon
      if @cpu_board.cells[target].empty?
        puts "Miss!"
      elsif @cpu_board.cells[target].empty? == false
        if @cpu_board.cells[target].ship.health >= 1 
        puts "Hit!"
        else
          puts "You sunk my #{@cpu_board.cells[target].ship.name}!"
          # if @cpu_cruiser.sunk? && @cpu_submarine.sunk?
          #   puts "Congrats! You've Won!!"
          # end
        end
      end
  end
    
  def cpu_shot
    target = @player_board.cells.keys.sample
    while @player_board.cells[target].fired_upon? == true
      target = @player_board.cells.keys.sample
    end
    @player_board.cells[target].fire_upon
    if @player_board.cells[target].empty?
      puts "Miss!"
    elsif @player_board.cells[target].empty? == false
      if @player_board.cells[target].ship.health >= 1 
        puts "Hit!"
      else
        puts "I sunk your #{@player_board.cells[target].ship.name}!"
        # if @player_cruiser.sunk? && @player_submarine.sunk?
        #   puts "You just lost to a computer!"
        # end
      end
    end
  end
    
  def player_has_lost?
    @player_cruiser.sunk? && @player_submarine.sunk?
  end
  
  def cpu_has_lost?
    @cpu_cruiser.sunk? && @cpu_submarine.sunk?
  end
  
  def play
    while player_has_lost? == false && cpu_has_lost? == false
      setup_game
      cpu_setup
      player_setup
      display_boards
      player_shot
      cpu_shot
    end
    if cpu_has_lost? == true 
      puts "You just lost to a computer!"
    elsif player_has_lost? == true
      puts "Congrats! You've Won!!"
    end
    display_boards
    start
  end
      # require 'pry'; binding.pry
end