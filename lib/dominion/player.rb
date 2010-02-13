class Dominion::Player
  def initialize(name="Anonymous")
    @name = name
  end

  def hand
    %w(Copper Copper Copper Estate Estate)
  end
end
