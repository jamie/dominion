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
    while player.available_actions > 0
      return if player.actions.empty?

      cards = player.ask("Play cards (#{player.available_actions} actions available).", player.actions, :count => 0..1)
      break if cards.empty?

      cards.each do |card|
        @game.other_players.tell "#{player.name} played #{card}"
        player.play(card, @game)
      end
    end
  end

  def run_buy_phase(player)
    player.tell "You have #{@game.current_player.available_coins} coins available to buy #{@game.current_player.available_buys} cards."
    while player.available_buys > 0
      cards = player.ask("Buy cards (#{player.available_buys} buys available).", @game.available_cards.select{|card|Card[card].cost <= player.available_coins}, :count => 0..1)
      break if cards.empty?

      cards.each do |card|
        if player.buy!(card)
          @game.track_purchase(card)
          player.tell "Purchased #{card}."
          @game.other_players.tell "#{player.name} purchased #{card}."
        else
          player.tell "Could not purchase #{card}, #{player.error}."
        end
      end
    end
  end

  def run_cleanup_phase(player)
    player.cleanup!
  end

end
