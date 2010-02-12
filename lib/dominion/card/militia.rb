class Dominion::Card::Militia < Dominion::Card
  comment %(
    +2 Coins
    Each other play discards down to 3 cards in their hand.
  )
  
  set "Dominion"
  type %w(Action Attack)
  cost 4
  
  extra_coins 2
  
  # TODO
end
