class Dominion::Deck
  attr_reader :stack, :hand, :discards, :in_play # :island?
  
  def initialize
    @stack = ["Copper"] * 7 + ["Estate"] * 3
    shuffle
    @hand = []
    @discards = []
    @in_play = []
  end
  
  def add_to_discards(card)
    @discards << card
  end
  
  def add_to_hand(card)
    @hand << card
    @hand.sort_by{|e|Card[e]}
  end
  
  def all_cards
    @stack + @discards + @hand + @in_play
  end
  
  def buy(card)
    @discards << card
  end
  
  def cleanup
    @discards += @in_play; @in_play = []
    @discards += @hand; @hand = []
  end
  
  def count(card)
    all_cards.count(card)
  end
  
  def discard(card)
    return false unless i = @hand.index(card)
    @discards << @hand.delete_at(i)
    card
  end
  
  def draw(n=1)
    new_cards = []
    n.times do
      card = top_card
      add_to_hand(card)
      new_cards << card
    end
    new_cards.sort_by{|e|Card[e]}
  end
  
  def draw_hand
    draw while @hand.size < 5
  end
  
  def top_card
    if @stack.empty?
      @stack, @discards = @discards, []
      shuffle
    end
    @stack.shift
  end
  
  def play(card)
    return unless i = @hand.index(card)
    @in_play << @hand.delete_at(i)
  end
  
  def shuffle
    @stack = @stack.sort_by{rand}
  end
  
  def trash(card)
    # TODO: make game inspect all players' trashes to enumerate its trash?
    return unless i = @hand.index(card)
    @hand.delete_at(i)
  end
end
