Dominion::Card.define_kingdom "Adventurer", 6, "Action"
Dominion::Card.define_kingdom "Bureaucrat", 4, "Action", "Attack"

Dominion::Card.define_kingdom "Cellar", 2, "Action" do
  set "Dominion"
  
  comment %(
    +1 Action
    Discard any number of cards. +1 Card per card discarded.
  )
  
  extra_actions 1

  action do |game|
    player = game.current_player
    discards = player.ask("Select any number of cards to discard.", [game.current_player.hand], :limit => 0..999)
    count = 0
    discards.each do |card|
      count += 1 if player.discard(card)
    end
    player.draw(count)
  end
end

Dominion::Card.define_kingdom "Chancellor", 3, "Action"
Dominion::Card.define_kingdom "Chapel", 2, "Action"
Dominion::Card.define_kingdom "Council Room", 5, "Action"
Dominion::Card.define_kingdom "Feast", 4, "Action"

Dominion::Card.define_kingdom "Festival", 5, "Action" do
  extra_actions 2
  extra_buys 1
  extra_coins 2
end

Dominion::Card.define_kingdom "Gardens", 4, "Victory"

Dominion::Card.define_kingdom "Laboratory", 5, "Action" do
  extra_actions 1
  extra_cards 2
end

Dominion::Card.define_kingdom "Library", 5, "Action"

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
  
  action do |game|
    game.other_players.each do |player|
      while player.hand.size > 3
        card = player.ask("Discard a card (#{player.hand.size-3} remaining)", player.hand)
        player.discard(card)
      end
    end
  end
end

Dominion::Card.define_kingdom "Mine", 5, "Action" do
  set "Dominion"

  comment %(
    Trash a Treasure card from your hand.
    Gain a Treasure card costing up to ¢3 more; put it into your hand.
  )
  
  action do |game|
    # TODO
  end
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
  
  reaction do |game, attack|
    # TODO
  end
end

Dominion::Card.define_kingdom "Moneylender", 4, "Action"

Dominion::Card.define_kingdom "Remodel", 4, "Action" do
  set "Dominion"

  comment %(
    Trash a card from your hand.
    Gain a card costing up to ¢2 more than the trashed card.
  )
  
  action do |game|
    # TODO
  end
end

Dominion::Card.define_kingdom "Smithy", 4, "Action" do
  set "Dominion"

  comment %(
    +3 Cards
  )
  
  extra_cards 3
end

Dominion::Card.define_kingdom "Spy", 4, "Action", "Attack"
Dominion::Card.define_kingdom "Thief", 4, "Action", "Attack"
Dominion::Card.define_kingdom "Throne Room", 4, "Action"

Dominion::Card.define_kingdom "Village", 3, "Action" do
  set "Dominion"

  comment %(
    +1 Card
    +2 Actions
  )
  
  extra_actions 2
  extra_cards 1
end

Dominion::Card.define_kingdom "Witch", 5, "Action", "Attack"

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
  
  action do |game|
    # TODO
  end
end
