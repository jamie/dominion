#Dominion::Card.define_kingdom "Adventurer"
#Dominion::Card.define_kingdom "Bureaucrat"

Dominion::Card.define_kingdom "Cellar", 2, "Action" do
  set "Dominion"
  
  comment %(
    +1 Action
    Discard any number of cards. +1 Card per card discarded.
  )
  
  extra_actions 1
  extra_cards do |player|
    cards = player.ask("Cards to discard?", :cards, :multi)
    # TODO
    # cards.each do |card|
    #   player.hand.discard(card)
    # end
    cards.count
  end
end

#Dominion::Card.define_kingdom "Chancellor"
#Dominion::Card.define_kingdom "Chapel"
#Dominion::Card.define_kingdom "Council Room"
#Dominion::Card.define_kingdom "Feast"
#Dominion::Card.define_kingdom "Festival"
#Dominion::Card.define_kingdom "Gardens"
#Dominion::Card.define_kingdom "Laboratory"
#Dominion::Card.define_kingdom "Library"

Dominion::Card.define_kingdom "Market", 5, "Action" do
  set "Dominion"

  comment %(
    +1 Card
    +1 Action
    +1 Buy
    +1 Coin
  )
  
  extra_actions 1
  extra_cards 1
  extra_buys 1
  extra_coins 1
end

Dominion::Card.define_kingdom "Militia", 4, "Action", "Attack" do
  set "Dominion"

  comment %(
    +2 Coins
    Each other play discards down to 3 cards in their hand.
  )
  
  extra_coins 2
  
  # TODO
end

Dominion::Card.define_kingdom "Mine", 5, "Action" do
  set "Dominion"

  comment %(
    Trash a Treasure card from your hand.
    Gain a Treasure card costing up to ¢3 more; put it into your hand.
  )
  
  # TODO
end

Dominion::Card.define_kingdom "Moat", 2, "Action", "Reaction" do
  set "Dominion"

  comment %(
    +2 Cards
    --
    When another player plays an Attack card, you may reveal this from your hand.
    If you do, you are unaffected by that attack.
  )
  
  extra_cards 2
  
  # TODO
end

#Dominion::Card.define_kingdom "Moneylender"

Dominion::Card.define_kingdom "Remodel", 4, "Action" do
  set "Dominion"

  comment %(
    Trash a card from your hand.
    Gain a card costing up to ¢2 more than the trashed card.
  )
  
  # TODO
end

Dominion::Card.define_kingdom "Smithy", 4, "Action" do
  set "Dominion"

  comment %(
    +3 Cards
  )
  
  extra_cards 3
end

#Dominion::Card.define_kingdom "Spy"
#Dominion::Card.define_kingdom "Thief"
#Dominion::Card.define_kingdom "Throne Room"

Dominion::Card.define_kingdom "Village", 3, "Action" do
  set "Dominion"

  comment %(
    +1 Card
    +2 Actions
  )
  
  extra_actions 2
  extra_cards 1
end

#Dominion::Card.define_kingdom "Witch"

Dominion::Card.define_kingdom "Woodcutter", 3, "Action" do
  set "Dominion"

  comment %(
    +1 Buy
    +2 Coins
  )
  
  extra_buys 1
  extra_coins 2
end

Dominion::Card.define_kingdom "Workshop", 3, "Action" do
  set "Dominion"

  comment %(
    Gain a card costing up to 4
  )
  
  # TODO
end
