require 'yaml'

sets = <<DATA
# Dominion
First Game: [Cellar, Market, Militia, Mine, Moat, Remodel, Smithy, Village, Woodcutter, Workshop]
Big Money: [Adventurer, Bureaucrat, Chancellor, Chapel, Feast, Laboratory, Market, Mine, Moneylender, Throne Room]
Interaction: [Bureaucrat, Chancellor, Council Room, Festival, Library, Militia, Moat, Spy, Thief, Village]
Size Distortion: [Cellar, Chapel, Feast, Gardens, Laboratory, Thief, Village, Witch, Woodcutter, Workshop]
Village Square: [Bureaucrat, Cellar, Festival, Library, Market, Remodel, Smithy, Throne Room, Village, Woodcutter]
# Intrigue
# Seaside
# Dominion + Intrigue
# Dominion + Seaside
# Intrigue + Seaside
# Dominion + Intrigue + Seaside
DATA

Dominion::Game.register_sets(YAML.load(sets))
