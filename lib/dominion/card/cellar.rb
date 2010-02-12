class Dominion::Card::Cellar < Dominion::Card
  comment %(
    +1 Action
    Discard any number of cards. +1 Card per card discarded.
  )
  
  set "Dominion"
  type "Action"
  cost 2
  
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
