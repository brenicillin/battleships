class Game
  attr_reader :cpu_board,
              :cpu_submarine,
              :cpu_cruiser,
              :player_board,
              :player_submarine,
              :player_cruiser,
              :cpu_shot

  def initialize
    @cpu_board = nil
    @cpu_submarine = nil
    @cpu_cruiser = nil
    @player_board = nil
    @player_submarine = nil
    @player_cruiser = nil
    @cpu_shot = nil
    @player_shot = nil
  end

  def start
    welcome = "\nWelcome to BATTLESHIP\nEnter p to play. Enter q to quit\n"
    puts welcome
    input = gets.chomp
    if input.upcase == 'P'
      clear
      setup_game
      cpu_setup
      player_setup
      clear
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
    clear
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
    
    clear
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
    print " "
    print "==========COMPUTER BOARD=========="
    print @cpu_board.render
    print "===========PLAYER BOARD==========="
    print @player_board.render(true) #ask about writing this test
    print " "
  end
  
  def player_shot
    puts "Where do you want to shoot?"
      @player_shot = gets.chomp.upcase
        while @cpu_board.valid_coordinate?(@player_shot) == false
          puts "Please select a target coordinate on the board"
          @player_shot = gets.chomp.upcase
        end
        while @cpu_board.cells[@player_shot].fired_upon? == true
          puts "You have aleady fired upon that coordinate"
          @player_shot = gets.chomp.upcase
        end
        @cpu_board.cells[@player_shot].fire_upon        
  end
    
  def comp_shot
    @cpu_shot = @player_board.cells.keys.sample
    while @player_board.cells[@cpu_shot].fired_upon? == true
      @cpu_shot = @player_board.cells.keys.sample
    end
    @player_board.cells[@cpu_shot].fire_upon
  end

  def cpu_shot_results
    if @player_board.cells[@cpu_shot].empty?
      pp "My shot on #{@cpu_shot} was a MISS!"
    elsif @player_board.cells[@cpu_shot].empty? == false
      if @player_board.cells[@cpu_shot].ship.health >= 1 
        pp "My shot on #{@cpu_shot} was a HIT!"
      else
        pp "My shot on #{@cpu_shot} sunk your #{@player_board.cells[@cpu_shot].ship.name}!"
      end
    end
  end

  def player_shot_results
    if @cpu_board.cells[@player_shot].empty?
      pp "Your shot on #{@player_shot} was a MISS!"
    elsif @cpu_board.cells[@player_shot].empty? == false
      if @cpu_board.cells[@player_shot].ship.health >= 1 
      pp "Your shot on #{@player_shot} was a HIT!"
      else
        pp "Your shot on #{@player_shot} sunk my #{@cpu_board.cells[@player_shot].ship.name}!"
      end
    end
  end

  def shot_results
    cpu_shot_results
    player_shot_results
  end
    
  def player_has_lost?
    @player_cruiser.sunk? && @player_submarine.sunk?
  end
  
  def cpu_has_lost?
    @cpu_cruiser.sunk? && @cpu_submarine.sunk?
  end

  def clear
    if Gem.win_platform?
      system 'cls'
    else
      system 'clear'
    end
  end
  
  def play
    while player_has_lost? == false && cpu_has_lost? == false
      display_boards
      player_shot
      cpu_shot
      clear
      shot_results
    end
    if cpu_has_lost? == true 
      clear
      display_boards
      puts "Congrats! You've Won!!"
      # require 'pry'; binding.pry
    elsif player_has_lost? == true
      clear
      display_boards
      puts "You just lost to a computer!"
    end
    puts '===================='
    start
  end
end