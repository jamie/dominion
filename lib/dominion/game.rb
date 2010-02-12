class Dominion::Game
  def initialize(players, cards = :random)
    @players = players
    
    init_cards(card_set(cards))
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
      if Card.named(name).victory?
        @cards[name] = number_of_victory_cards
      else
        @cards[name] = 10
      end
    end
  end
  
  def remaining(card)
    @cards[card]
  end
  
private
  def card_set(cards)
    case cards
    when Array; cards
    when :random; Card.all.sort_by{|e|rand}[0...10]
    #when "First Game"; ["Cellar", "..."]
    else []
    end
  end

  def number_of_victory_cards
    case @players.count
    when 2;    8
    when 3,4; 12
    end
  end
end
