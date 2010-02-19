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
  
  context "action card effects" do
    setup do
      @p1 = Player.new
      @p2 = Player.new

      @game = Game.new([@p1, @p2], [])
      @game.start
    end
  
    context "Cellar" do
      should "allow 1 extra draw per card discarded" do
        @p1.expects(:ask).returns("Copper")
        Card['Cellar'].call(@game)

        assert_equal 1, @p1.discards.size
        assert_equal 5, @p1.hand.size
      end
    end
  
    context "Militia" do
      should "grant two extra coins" do
        coins = @p1.available_coins
        
        @p2.expects(:ask).returns(["Copper", "Copper"])
        Card['Militia'].call(@game)
        
        assert_equal coins+2, @p1.available_coins
      end
      
      should "prompt p2 to discard 2 cards" do
        @p2.expects(:ask).returns(["Copper", "Copper"])
        Card['Militia'].call(@game)
        
        assert_equal 3, @p2.hand.size
      end
    end

    context "Mine" do
      should "allow exchanging a Copper for a Silver" do
        @p1.expects(:ask).returns("Copper")
        @p1.expects(:ask).with{|prompt, choices|
          choices == ["Copper", "Silver"]
        }.returns("Silver")
        Card['Mine'].call(@game)

        assert_equal 6, @p1.deck.count('Copper')
        assert_equal 1, @p1.deck.count('Silver')
      end
    end

    context "Remodel" do
      should "allow trashing Copper for Estate" do
        @p1.expects(:ask).with{|prompt, choices|
          prompt == "Select a card to trash."
        }.returns("Copper")
        @p1.expects(:ask).with{|prompt, choices|
          prompt == "Select a new card to gain." and choices.include? "Estate"
        }.returns("Estate")
        Card['Remodel'].call(@game)

        assert_equal 6, @p1.deck.count('Copper')
        assert_equal 4, @p1.deck.count('Estate')
      end
    end

    context "Workshop" do
      should "add card to discards" do
        @p1.expects(:ask).with{|prompt, choices|
          choices.include? "Silver"
        }.returns("Silver")
        Card['Workshop'].call(@game)

        assert_equal ["Silver"], @p1.discards
      end
    end
  end
end
