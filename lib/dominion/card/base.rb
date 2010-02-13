Dominion::Card.define_base 'Copper',    0, "Treasure" do coins 1 end
Dominion::Card.define_base 'Silver',    3, "Treasure" do coins 2 end
Dominion::Card.define_base 'Gold',      6, "Treasure" do coins 3 end

Dominion::Card.define_base 'Estate',    2, "Victory"  do vp  1 end
Dominion::Card.define_base 'Duchy',     5, "Victory"  do vp  3 end
Dominion::Card.define_base 'Province',  8, "Victory"  do vp  6 end
Dominion::Card.define_base 'Curse',     0, "Curse"    do vp -1 end
