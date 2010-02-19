class Dominion::Player
  extend Forwardable
  attr_reader :name, :io, :error, :deck
  attr_accessor :extra_actions, :extra_buys, :extra_coins
  
  def_delegators :@deck,
    :discard, :discards,
    :draw, :draw_hand,
    :hand, :trash

  def initialize(name="Anonymous", io=StandardIO)
    @io = io.new
    @name = name
    @deck = Deck.new
    cleanup!
  end

  def ask(prompt, responses, options={})
    range = case options[:count]
      when Range ; options[:count]
      when Fixnum; options[:count] .. options[:count]
      else         1..1
    end
    
    @io.puts prompt
    responses.each_with_index do |response, i|
      @io.puts "%2s: %s" % [i+1, response]
    end
    
    selections = []
    loop do
      @io.print "? "
      input = @io.gets.chomp
      selections += input.scan(/\d+/).map{|i|i.to_i}
      selections.reject!{|e|e < 1 || e > responses.size}
      selections.uniq!
      
      break if selections.size >= range.last
      break if input.empty? && selections.size >= range.first
    end
    @io.puts
    
    selections = selections.map{|i|responses[i-1]}
    if options[:count].nil?
      selections.first
    elsif range.last == INFINITY
      selections
    else
      selections[0...range.last]
    end
  end
  
  def available_actions
    1 + @extra_actions - @actions_played
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
    
    @actions_played = 0
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
