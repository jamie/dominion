Dominion::Card.define_kingdom "Adventurer", 6, "Action" do
  comment "Reveal cards from your deck until you reveal 2 Treasure cards.\nPlace those cards in your hand and discard the rest."
  set "Dominion"
  
  action do |game|
    game.current_player do |player|
      treasures = []
      discards = []
      while treasures.size < 2
        card = player.deck.top_card
        if Card[card].treasure?
          treasures << card
          player.deck.add_to_hand(card)
          action = :deck_to_hand
        else
          discards << card
          player.deck.add_to_discards(card)
          action = :deck_discard
        end
        game.reveal(player, card, action)
      end
    end
  end
end
Dominion::Card.define_kingdom "Bureaucrat", 4, "Action", "Attack" do
  comment "Gain a Silver to the top of your deck.\nEach other player reveals a Treasure from their hand, and places it on top of their deck."
  set "Dominion"
  
  action do |game|
    game.current_player.deck.stack.unshift("Silver")
    game.other_players.each do |player|
      player.attack(self, game) do
        v_cards = player.hand.select{|c|Card[c].victory?}
        if v_cards.empty?
          game.reveal(player, player.hand, :hand)
        else
          player.ask("Reveal a card and have it placed on top of your deck") do |card|
            player.deck.return_to_stack(card)
            game.reveal(player, card, :hand_to_deck)
          end
        end
      end
    end
  end
end
Dominion::Card.define_kingdom "Cellar", 2, "Action" do
  comment "+1 Action\nDiscard any number of cards. +1 Card per card discarded."
  set "Dominion"
  
  extra_actions 1

  action do |game|
    game.current_player do |player|
      discards = player.ask("Select any number of cards to discard.", player.hand, :count => 0..INFINITY)
      count = 0
      discards.each do |card|
        count += 1 if player.discard(card)
      end
      new_cards = player.draw(count)
      player.tell "Drew #{new_cards.join(', ')}"
      game.other_players.tell "#{player.name} discarded #{discards.join(', ')} and drew #{new_cards.size} cards."
    end
  end
end
Dominion::Card.define_kingdom "Chancellor", 3, "Action"
Dominion::Card.define_kingdom "Chapel", 2, "Action"
Dominion::Card.define_kingdom "Council Room", 5, "Action"
Dominion::Card.define_kingdom "Feast", 4, "Action"
Dominion::Card.define_kingdom "Festival", 5, "Action" do
  comment "+2 Actions, +1 Buy, +2 Coins"
  set "Dominion"
  
  extra_actions 2
  extra_buys 1
  extra_coins 2
end
Dominion::Card.define_kingdom "Gardens", 4, "Victory"
Dominion::Card.define_kingdom "Laboratory", 5, "Action" do
  comment "+2 Cards, +1 Action"
  set "Dominion"
  
  extra_actions 1
  extra_cards 2
end
Dominion::Card.define_kingdom "Library", 5, "Action"
Dominion::Card.define_kingdom "Market", 5, "Action" do
  comment "+1 Card, +1 Action, +1 Buy, +1 Coin"
  set "Dominion"

  extra_actions 1
  extra_cards 1
  extra_buys 1
  extra_coins 1
end
Dominion::Card.define_kingdom "Militia", 4, "Action", "Attack" do
  comment "+2 Coins\nEach other player discards down to 3 cards in their hand."
  set "Dominion"

  extra_coins 2
  
  action do |game|
    game.other_players.each do |player|
      player.attack(self, game) do
        cards = player.ask("Discard down to 3 cards.", player.hand, :count => player.hand.size-3)
        cards.each {|card| player.discard(card)}
        player.tell "Discarded #{cards.join(', ')}"
        game.other_players(player).tell "#{player.name} discarded #{cards.join(', ')}"
      end
    end
  end
end
Dominion::Card.define_kingdom "Mine", 5, "Action" do
  comment "Trash a Treasure from your hand to gain another costing up to ¢3 more.\nPut the new Treasure into your hand."
  set "Dominion"
  
  action do |game|
    game.current_player do |player|
      player.ask("Select a Treasure to trash.", player.hand.select{|c|Card[c].treasure?}) do |trashed|
        to_gain = game.available_cards.select{|c| Card[c].treasure? and Card[c].cost <= Card[trashed].cost + 3}
        player.ask("Select a new Treasure card to gain.", to_gain) do |gained|
          player.trash(trashed)
          player.hand << gained
        end
      end
    end
  end
end
Dominion::Card.define_kingdom "Moat", 2, "Action", "Reaction" do
  comment "+2 Cards\nWhen another player plays an Attack card, you may reveal this from your hand.\nIf you do, you are unaffected by that attack."
  set "Dominion"

  extra_cards 2

  reaction do |player, &attack|
    # return a null proc to cancel the attack's effect
    lambda {}
  end
end
Dominion::Card.define_kingdom "Moneylender", 4, "Action"
Dominion::Card.define_kingdom "Remodel", 4, "Action" do
  comment "Trash a card from your hand, gain a card costing up to ¢2 more than it."
  set "Dominion"
  
  action do |game|
    game.current_player do |player|
      player.ask("Select a card to trash.", player.hand) do |trashed|
        to_gain = game.available_cards.select{|c| Card[c].cost <= Card[trashed].cost + 2}
        player.ask("Select a new card to gain.", to_gain) do |gained|
          player.trash(trashed)
          player.discards << gained
        end
      end
    end
  end
end
Dominion::Card.define_kingdom "Smithy", 4, "Action" do
  comment "+3 Cards"
  set "Dominion"

  extra_cards 3
end
Dominion::Card.define_kingdom "Spy", 4, "Action", "Attack"
Dominion::Card.define_kingdom "Thief", 4, "Action", "Attack"
Dominion::Card.define_kingdom "Throne Room", 4, "Action"
Dominion::Card.define_kingdom "Village", 3, "Action" do
  comment "+1 Card, +2 Actions"
  set "Dominion"
  
  extra_actions 2
  extra_cards 1
end
Dominion::Card.define_kingdom "Witch", 5, "Action", "Attack"
Dominion::Card.define_kingdom "Woodcutter", 3, "Action" do
  comment "+1 Buy, +2 Coins"
  set "Dominion"

  extra_buys 1
  extra_coins 2
end
Dominion::Card.define_kingdom "Workshop", 3, "Action" do
  comment "Gain a card costing up to 4"
  set "Dominion"

  action do |game|
    game.current_player do |player|
      to_gain = game.available_cards.select{|c| Card[c].cost <= 4}
      player.ask("Select a new card to gain.", to_gain) do |card|
        player.discards << card
      end
    end
  end
end
