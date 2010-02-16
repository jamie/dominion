class Dominion::Deck
  attr_reader :stack, :hand, :discards, :in_play # :island?
  
  def initialize
    @stack = ["Copper"] * 7 + ["Estate"] * 3
    shuffle
    @hand = []
    @discards = []
    @in_play = []
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
    n.times do
      if @stack.empty?
        @stack, @discards = @discards, []
        shuffle
      end
      @hand << @stack.shift
    end
    @hand.sort_by{|e|Card[e]}
  end
  
  def draw_hand
    draw while @hand.size < 5
  end
  
  def play(card)
    return unless i = @hand.index(card)
    @in_play << @hand.delete_at(i)
  end
  
  def shuffle
    @stack = @stack.sort_by{rand}
  end
  
  def trash(card)
    return unless i = @hand.index(card)
    @hand.delete_at(i)
  end
end
