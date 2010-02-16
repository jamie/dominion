class Dominion::CLI
  def initialize(game, input=STDIN, output=STDOUT)
    @game = game
    @input = input
    @output = output
  end
  
  def cards_available
    buff = StringIO.new
    buff.puts "Cards Available:"
    @game.cards.each_with_index do |e,i|
      card, count = e
      buff.puts "  %2s. [%i] %-16s (%2s remain)" % [i+1, Card[card].cost, card, count]
    end
    buff.string
  end
  
  def current_hand(player)
    "Current Hand: " + player.hand.join(", ")
  end
  
  def game_results
    buff = StringIO.new
    buff.puts "Game Results\n~~~~~~~~~~~~\n"
    # TODO
    buff.string
  end

  def run
    @game.start
    
    @game.all_players.tell "New Game\n--------"
    
    while !@game.over?
      player = @game.current_player
      @game.all_players.tell "#{player.name}'s Turn."
      player.tell cards_available
      player.tell current_hand(player)

      run_action_phase(player)
      run_buy_phase(player)
      run_cleanup_phase(player)
      
      @game.next_player!
    end
  rescue IOError
    @game.all_players.tell "\nLost a player, game ended."
  ensure
    @game.all_players.tell game_results
  end

  def run_action_phase(player)
    #card = player.ask "Select an action, <return> to skip: "
  end

  def run_buy_phase(player)
    player.tell "You have #{@game.current_player.available_coins} coins available to buy #{@game.current_player.available_buys} cards."
    while player.available_buys > 0
      id = player.ask("Buy which card (enter to stop buying)?")
      break if id.empty?

      card = @game.cards[id.to_i-1][0]
      if player.buy!(card)
        player.tell "Purchased #{card}."
        @game.other_players.tell "#{player.name} purchased #{card}."
      else
        player.tell "Could not purchase #{card}, #{player.error}."
      end
    end
  end

  def run_cleanup_phase(player)
    player.cleanup!
  end

end
