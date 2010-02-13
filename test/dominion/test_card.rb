require 'test_helper'

class TestCard < Test::Unit::TestCase
  context "meta hooks" do
    should "set" do
      assert_equal "Dominion", Card.named('Smithy').set
    end

    should "type" do
      assert Card.named('Smithy').action?
      assert_equal false, Card.named('Smithy').victory?
    end

    should "extra_actions" do
      assert_equal 1, Card.named('Cellar').extra_actions
      assert_equal nil, Card.named('Smithy').extra_actions
    end
    
    should "extra_cards" do
      assert_equal 3, Card.named('Smithy').extra_cards
    end
  end
  
  context "Victory" do
    should "be worth victory points" do
      assert_equal 1, Card.named('Estate').vp
      assert_equal 3, Card.named('Duchy').vp
      assert_equal 6, Card.named('Province').vp
      assert_equal -1, Card.named('Curse').vp
    end
    
    should "have costs" do
      assert_equal 2, Card.named('Estate').cost
      assert_equal 5, Card.named('Duchy').cost
      assert_equal 8, Card.named('Province').cost
      assert_equal 0, Card.named('Curse').cost
    end
  end
  
  context "Treasure" do
    should "be worth coins" do
      assert_equal 1, Card.named('Copper').coins
      assert_equal 2, Card.named('Silver').coins
      assert_equal 3, Card.named('Gold').coins
    end
    
    should "have costs" do
      assert_equal 0, Card.named('Copper').cost
      assert_equal 3, Card.named('Silver').cost
      assert_equal 6, Card.named('Gold').cost
    end
  end
  
  context "Cellar" do
    should "allow 1 extra card per card discarded" do
      player = Player.new
      player.expects(:ask).returns(%w(Copper))
      assert_equal 1, Card.named('Cellar').extra_cards_for(player)
    end
  end
end
