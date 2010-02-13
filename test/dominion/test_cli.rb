require 'test_helper'
require 'dominion/cli'

class TestDominionCLI < Test::Unit::TestCase
  context "game setup" do
    setup do
      @stdin = StringIO.new
      @stdout = StringIO.new
      srand(11234)
      
      @p1 = Player.new('Bob')
      @p2 = Player.new('Alice')
      
      @game = Game.new([@p1, @p2], [])
      @cli = Dominion::CLI.new(@game, @stdin, @stdout)
    end
    
    should "display cards available for game" do
      @stdin.close
      @cli.run
      @stdout.rewind
      assert_match /\d+. Province \(8 remain\)/, @stdout.read
    end
    
    should "display hand" do
      @stdin.close
      @cli.run
      @stdout.rewind
      assert_match /1. Copper/, @stdout.read
    end
    
    should "prompt for first move"
  end
  
end
