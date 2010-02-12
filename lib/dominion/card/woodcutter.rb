class Dominion::Card::Woodcutter < Dominion::Card
  comment %(
    +1 Buy
    +2 Coins
  )
  
  set "Dominion"
  type "Action"
  cost 3
  
  extra_buys 1
  extra_coins 2
end
