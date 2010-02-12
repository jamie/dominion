require 'test_helper'

class TestDominionGame < Test::Unit::TestCase
  context "Two-player setup" do
    setup do
      @g = Game.new([1,2])
    end
    
    should "include eight of each Victory card" do
      assert_equal 8, @g.remaining("Estate")
      assert_equal 8, @g.remaining("Duchy")
      assert_equal 8, @g.remaining("Province")
    end
    
    should "include a bunch of Treasure cards" do
      assert_equal 60-14, @g.remaining("Copper")
      assert_equal 40, @g.remaining("Silver")
      assert_equal 30, @g.remaining("Gold")
    end
  end
  
  context "Three-player setup" do
    setup do
      @g = Game.new([1,2,3])
    end
    
    should "include twelve of each Victory card" do
      assert_equal 12, @g.remaining("Estate")
      assert_equal 12, @g.remaining("Duchy")
      assert_equal 12, @g.remaining("Province")
    end
    
    should "include a bunch of Treasure cards" do
      assert_equal 60-21, @g.remaining("Copper")
      assert_equal 40, @g.remaining("Silver")
      assert_equal 30, @g.remaining("Gold")
    end
  end
  
  context "Four-player setup" do
    setup do
      @g = Game.new([1,2,3,4])
    end
    
    should "include twelve Estates" do
      assert_equal 12, @g.remaining("Estate")
      assert_equal 12, @g.remaining("Duchy")
      assert_equal 12, @g.remaining("Province")
    end
    
    should "include a bunch of Treasure cards" do
      assert_equal 60-28, @g.remaining("Copper")
      assert_equal 40, @g.remaining("Silver")
      assert_equal 30, @g.remaining("Gold")
    end
  end
  
end
