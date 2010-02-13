class Dominion::CLI
  def initialize(game, input=STDIN, output=STDOUT)
    @game = game
    @input = input
    @output = output
  end
  
  def gets(*args)
    @input.gets(*args).chomp
  end
  
  def print(*args)
    @output.print(*args)
  end
  
  def puts(*args)
    @output.puts(*args)
  end
  
  def puts_game_cards
    puts "Cards Available:"
    @game.cards.each_with_index do |e,i|
      card, count = e
      puts "  #{i+1}. #{card} (#{count} remain)"
    end
  end
  
  def puts_hand(hand)
    puts "Current Hand:"
    hand.each_with_index do |e,i|
      puts "  #{i+1}. #{e}"
    end
  end
  
  def run
    puts "New Game"
    puts "--------"
    puts
    
    while !@game.over?
      player = @game.current_player
      puts_game_cards
      puts_hand(player.hand)
      print "Select an action, <return> to skip: "
      card = gets
      
      @game.next_player!
    end
  rescue IOError
    puts
    puts "STDIN closed for reading, game ended."
  end
end
