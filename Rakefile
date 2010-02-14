$: << 'lib'

task :progress do
  require 'dominion'
  missing = {}
  lacking = {}
  Dominion::Game.sets.each do |set, cards|
    cards.each do |card|
      unless Dominion::Card.named(card)
        missing[card] ||= []
        missing[card] << set
        lacking[set] ||= []
        lacking[set] << card
      end
    end
  end
  
  puts "Incomplete Sets:"
  lacking.keys.sort.each do |set|
    puts "(#{10-lacking[set].size}/10) #{set}: #{lacking[set].join(', ')}"
  end
  puts
  
  puts "Missing Cards"
  missing.keys.sort.each do |card|
    puts "(#{missing[card].size}) #{card}: #{missing[card].join(', ')}"
  end
end
