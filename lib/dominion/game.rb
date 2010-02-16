class Dominion::Game
  class << self
    attr_accessor :sets
  end
  
  def initialize(players, cards = :random)
    @players = players
    
    init_cards(card_set(cards))
  end
  
  def cards
    @cards.keys.sort_by do |name|
      Card[name]
    end.map{|name| [name, @cards[name]]}
  end

  def current_player
    @players.first
  end

  def other_players
    PlayerProxy.new(@players - [current_player])
  end

  def all_players
    PlayerProxy.new(@players)
  end

  def init_cards(extras)
    @cards = Hash.new(0)
    @cards["Copper"] = 60 - 7 * @players.count
    @cards["Silver"] = 40
    @cards["Gold"] = 30
    
    @cards["Estate"] = number_of_victory_cards
    @cards["Duchy"] = number_of_victory_cards
    @cards["Province"] = number_of_victory_cards
    
    @cards["Curse"] = 10 * (@players.count - 1)
    
    extras.each do |name|
      if Card[name].victory?
        @cards[name] = number_of_victory_cards
      else
        @cards[name] = 10
      end
    end
  end
  
  def next_player!
    @players.push @players.shift
  end

  def over?
    @cards.values.count(0) >= 3
  end

  def remaining(card)
    @cards[card]
  end
  
  def start
    all_players.draw_hand
  end
  
private
  def card_set(cards)
    case cards
    when Array; cards
    when :random
      Card.kingdom.sort_by{rand}[0...10]
    when 'Dominion', 'Intrigue', 'Seaside'
      Card.kingdom.select{|c|Card[c].set == cards}.sort_by{rand}[0...10]
    else
      Game.sets[cards] || []
    end
  end

  def number_of_victory_cards
    case @players.count
    when 2;    8
    when 3,4; 12
    else       0
    end
  end
end
