require 'yaml'

sets = <<DATA
# Dominion
First Game: [Cellar, Market, Militia, Mine, Moat, Remodel, Smithy, Village, Woodcutter, Workshop]
Big Money: [Adventurer, Bureaucrat, Chancellor, Chapel, Feast, Laboratory, Market, Mine, Moneylender, Throne Room]
Interaction: [Bureaucrat, Chancellor, Council Room, Festival, Library, Militia, Moat, Spy, Thief, Village]
Size Distortion: [Cellar, Chapel, Feast, Gardens, Laboratory, Thief, Village, Witch, Woodcutter, Workshop]
Village Square: [Bureaucrat, Cellar, Festival, Library, Market, Remodel, Smithy, Throne Room, Village, Woodcutter]

# Seaside
High Seas: [Bazaar, Caravan, Embargo, Explorer, Haven, Island, Lookout, Pirate Ship, Smugglers, Wharf]
Buried Treasure: [Ambassador, Cutpurse, Fishing Village, Lighthouse, Outpost, Pearl Diver, Tactician, Treasure Map, Warehouse, Wharf]
Shipwrecks: [Ghost Ship, Merchant Ship, Native Village, Navigator, Pearl Diver, Salvager, Sea Hag, Smugglers, Treasury, Warehouse]

# Dominion + Seaside
Reach for Tomorrow: [Adventurer, Cellar, Council Room, Cutpurse, Ghost Ship, Lookout, Sea Hag, Spy, Treasure Map, Village]
Repetition: [Caravan, Chancellor, Explorer, Festival, Militia, Outpost, Pearl Diver, Pirate Ship, Treasury, Warehouse]
Give and Take: [Ambassador, Fishing Village, Haven, Island, Library, Market, Moneylender, Salvager, Smugglers, Witch]

# Intrigue
Victory Dance: [Bridge, Duke, Great Hall, Harem, Ironworks, Masquerade, Nobles, Pawn, Scout, Upgrade]
Secret Schemes: [Conspirator, Harem, Ironworks, Pawn, Saboteur, Shanty Town, Steward, Swindler, Trading Post, Tribute]
Best Wishes: [Coppersmith, Courtyard, Masquerade, Scout, Shanty Town, Steward, Torturer, Trading Post, Upgrade, Wishing Well]

# Dominion + Intrigue
Deconstruction: [Bridge, Mining Village, Remodel, Saboteur, Secret Chamber, Spy, Swindler, Thief, Throne Room, Torturer]
Hand Madness: [Bureaucrat, Chancellor, Council Room, Courtyard, Mine, Militia, Minion, Nobles, Steward, Torturer]
Underlings: [Baron, Cellar, Festival, Library, Masquerade, Minion, Nobles, Pawn, Steward, Witch]

DATA

Dominion::Game.sets = YAML.load(sets)
