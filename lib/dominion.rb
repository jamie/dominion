module Dominion; end

require 'dominion/card'
require 'dominion/deck'
require 'dominion/player'
require 'dominion/game'

Dir['lib/dominion/card/*.rb'].each do |file|
  require file.chomp('.rb')
end
