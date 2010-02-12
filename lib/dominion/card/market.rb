class Dominion::Card::Market < Dominion::Card
  comment %(
    +1 Card
    +1 Action
    +1 Buy
    +1 Coin
  )
  
  set "Dominion"
  type "Action"
  cost 5
  
  extra_actions 1
  extra_cards 1
  extra_buys 1
  extra_coins 1
end
