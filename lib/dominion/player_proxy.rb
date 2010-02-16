class Dominion::PlayerProxy
  def initialize(*players)
    @players = players.flatten
  end
  
  def method_missing(method, *args)
    @players.each do |player|
      player.send(method, *args)
    end
  end
end
