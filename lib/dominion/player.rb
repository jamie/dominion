class Dominion::Player
  attr_reader :hand

  def initialize(name="Anonymous")
    @name = name
    @discards = []
    @hand = %w(Copper Copper Copper Estate Estate)
  end

  def discard!(card)
    return false unless @hand.include? card
    card = @hand.delete_at(@hand.index(card))
    @discards << card
    card
  end

end
