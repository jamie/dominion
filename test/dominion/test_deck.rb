require 'test_helper'

class TestCard < Test::Unit::TestCase
  context "" do
    setup do
      @deck = Deck.new
    end
  
    context "new deck" do
      should "contain 3 estates" do
        assert_equal 3, @deck.count("Estate")
      end
    
      should "contain 7 copper" do
        assert_equal 7, @deck.count("Copper")
      end
    end
  
    context ".buy" do
      should "add a card to the discard pile" do
        @deck.buy("Estate")
        assert_equal 4, @deck.count("Estate")
        assert_equal 1, @deck.discards.size
      end
    end
  
    context ".cleanup" do
      should "place cards in play into discard pile" do
        @deck.hand << "Cellar"
        @deck.play("Cellar")
        @deck.cleanup
        assert_equal 0, @deck.in_play.size
        assert_equal 1, @deck.discards.size
      end
      
      should "place cards in hand into discard pile" do
        @deck.draw_hand
        @deck.cleanup
        assert_equal 0, @deck.hand.size
        assert_equal 5, @deck.discards.size
      end
    end
  
    context ".discard" do
      should "place a card from hand into discard pile" do
        @deck.draw_hand
        @deck.discard("Copper")
        assert_equal ["Copper"], @deck.discards
        assert_equal 4, @deck.hand.size
      end
    end
  
    context ".draw_hand" do
      should "put 5 cards in hand" do
        @deck.draw_hand
        assert_equal 5, @deck.hand.size
      end
      
      should "leave 5 cards in stack" do
        @deck.draw_hand
        assert_equal 5, @deck.stack.size
      end
    end
  
    context ".draw" do
      should "remove a card from the stack and add to hand" do
        @deck.draw
        assert_equal 1, @deck.hand.size
      end
      
      should "shuffle discards into stack if stack is empty" do
        @deck.draw_hand
        5.times {@deck.draw}
        3.times {@deck.discard("Estate")}
        @deck.draw
        assert_equal 2, @deck.stack.size
        assert_equal 0, @deck.discards.size
        assert_equal 8, @deck.hand.size
      end
    end
  
    context ".play" do
      should "move a card from hand to play area" do
        @deck.hand << "Cellar"
        assert_equal 1, @deck.hand.size
        @deck.play("Cellar")
        assert_equal ["Cellar"], @deck.in_play
        assert_equal 0, @deck.hand.size
      end
    end
  
    context ".trash" do
      should "remove a card from hand completely" do
        @deck.draw_hand
        @deck.trash("Copper")
        assert_equal 6, @deck.count("Copper")
        assert_equal 4, @deck.hand.size
      end
    end
  end  
end
