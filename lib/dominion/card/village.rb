class Dominion::Card::Village < Dominion::Card
  comment %(
    +1 Card
    +2 Actions
  )
  
  set "Dominion"
  type "Action"
  cost 4
  
  extra_actions 2
  extra_cards 1
end
