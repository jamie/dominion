class Dominion::Card::Moat < Dominion::Card
  comment %(
    +2 Cards
    --
    When another player plays an Attack card, you may reveal this from your hand.
    If you do, you are unaffected by that attack.
  )
  
  set "Dominion"
  type %w(Action Reaction)
  cost 2
  
  extra_cards 2
  
  # TODO
end
