require 'test_helper'
require 'dominion/cli'

class TestDominionCLI < Test::Unit::TestCase
  context "game setup" do
    setup do
      srand(11234)
      
      @p1 = Player.new('Bob', BufferIO)
      @p2 = Player.new('Alice', BufferIO)
      
      @game = Game.new([@p1, @p2], "First Game")
      @cli = Dominion::CLI.new(@game)
    end
    
    should "display cards available for game" do
      @p1.io.reader.close
      @cli.run
      assert_match /16. \[8\] Province +\( 8 remain\)/, @p1.io.writer.string
    end
    
    should "display hand only to current player" do
      @p1.io.reader.close
      @cli.run
      assert_match /Copper, /, @p1.io.writer.string
      assert_no_match /Copper, /, @p2.io.writer.string
    end
    
    context "buy cards" do
      should "inform buyer" do
        @p1.io.reader.puts("10", "^D")
        @p1.io.reader.rewind
        @p2.io.close
        @cli.run
        assert_match /Buy which card/, @p1.io.writer.string
        assert_match /Purchased Silver./, @p1.io.writer.string
      end

      should "inform others" do
        @p1.io.reader.puts("10", "^D")
        @p1.io.reader.rewind
        @p2.io.close
        @cli.run
        assert_match /Bob purchased Silver./, @p2.io.writer.string
      end

      should "inform buyer of problems" do
        @p1.io.reader.puts("16", "", "^D")
        @p1.io.reader.rewind
        @p2.io.close
        @cli.run
        assert_match /Buy which card/, @p1.io.writer.string
        assert_no_match /Purchased/, @p1.io.writer.string
      end
    end
  end
  
end
