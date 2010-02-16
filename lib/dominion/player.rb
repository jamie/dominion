class Dominion::Player
  attr_reader :name, :hand, :io, :error

  def initialize(name="Anonymous", io=StandardIO)
    @io = io.new
    @name = name
    @error = ""
    @discards = []
    cleanup!
  end

  def ask(question)
    @io.print question
    output = @io.gets.chomp
    @io.puts
    output
  end

  def available_buys
    hand.map{|c|Card.named(c).buys}.compact.inject(0){|a,b|a+b} + 1
    # TODO: Actions giving buys
    # TODO: -used buys
  end

  def available_coins
    hand.map{|c|Card.named(c).coins}.compact.inject(0){|a,b|a+b} - @coins_spent
    # TODO: Actions giving coins
  end

  def buy!(name)
    card = Card.named(name)
    if spend! card.cost
      @discards << name
      true
    else
      @error = "Insufficient coins to buy card"
      false
    end
  end

  def cleanup!
    @hand = %w(Copper Copper Copper Estate Estate)
    @coins_spent = 0
  end

  def discard!(card)
    return false unless @hand.include? card
    card = @hand.delete_at(@hand.index(card))
    @discards << card
    card
  end

  def tell(statement)
    @io.puts statement
    @io.puts
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
