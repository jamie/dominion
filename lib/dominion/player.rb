class Dominion::Player
  extend Forwardable
  attr_reader :name, :io, :error
  attr_accessor :extra_actions, :extra_buys, :extra_coins
  
  def_delegators :@deck,
    :discard, :discards,
    :draw, :draw_hand,
    :hand

  def initialize(name="Anonymous", io=StandardIO)
    @io = io.new
    @name = name
    @deck = Deck.new
    cleanup!
  end

  def ask(question, responses=[], options={})
    @io.print question, ' '
    output = @io.gets.chomp
    @io.puts
    # TODO: look up response in list, return that instead, if responses.kind_of? Array
    output
  end

  def available_buys
    1 + @extra_buys - @cards_bought
  end

  def available_coins
    coins_in_hand + @extra_coins - @coins_spent
  end

  def buy!(name)
    card = Card[name]
    if spend! card.cost
      @deck.buy(name)
      @cards_bought += 1
      true
    else
      @error = "Insufficient coins to buy card"
      false
    end
  end

  def cleanup!
    @extra_actions = 0
    @extra_coins = 0
    @extra_buys = 0
    
    @coins_spent = 0
    @cards_bought = 0
    
    @error = ""
    draw_hand
  end
  
  def coins_in_hand
    hand.map{|c|Card[c].coins}.compact.inject(0){|a,b|a+b}
  end

  def discard!(card)
    return false unless @deck.discard(card)
    card
  end

  def tell(statement)
    @io.puts statement
  end

  def spend!(amount)
    if available_coins >= amount
      @coins_spent += amount
      true
    else
      false
    end
  end

end
