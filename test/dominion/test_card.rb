require 'test_helper'

class TestCard < Test::Unit::TestCase
  context "meta hooks" do
    should "set" do
      assert_equal "Dominion", Card['Smithy'].set
    end

    should "type" do
      assert Card['Smithy'].action?
      assert_equal false, Card['Smithy'].victory?
    end

    should "extra_actions" do
      assert_equal 1, Card['Cellar'].extra_actions
      assert_equal nil, Card['Smithy'].extra_actions
    end
    
    should "extra_cards" do
      assert_equal 3, Card['Smithy'].extra_cards
    end
  end
  
  context "Victory" do
    should "be worth victory points" do
      assert_equal 1, Card['Estate'].vp
      assert_equal 3, Card['Duchy'].vp
      assert_equal 6, Card['Province'].vp
      assert_equal -1, Card['Curse'].vp
    end
    
    should "have costs" do
      assert_equal 2, Card['Estate'].cost
      assert_equal 5, Card['Duchy'].cost
      assert_equal 8, Card['Province'].cost
      assert_equal 0, Card['Curse'].cost
    end
  end
  
  context "Treasure" do
    should "be worth coins" do
      assert_equal 1, Card['Copper'].coins
      assert_equal 2, Card['Silver'].coins
      assert_equal 3, Card['Gold'].coins
    end
    
    should "have costs" do
      assert_equal 0, Card['Copper'].cost
      assert_equal 3, Card['Silver'].cost
      assert_equal 6, Card['Gold'].cost
    end
  end
  
  context "Cellar" do
    should "allow 1 extra draw per card discarded" do
      p1 = Player.new
      p2 = Player.new

      game = Game.new([p1, p2], [])
      game.start

      p1.expects(:ask).returns(%w(Copper))
      Card['Cellar'].call(game)

      assert_equal 1, p1.discards.size
      assert_equal 5, p1.hand.size
    end
  end
end
