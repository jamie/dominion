require 'test_helper'

class TestCard < Test::Unit::TestCase
  context "ask" do
    setup do
      @p = Player.new("Anon", BufferIO)
    end
    
    context "general" do
      setup do
        @p.io.reader.stubs(:gets).returns("1", "")
      end
    
      should "prompt the player" do
        @p.ask("foo.", ["bar"])
        assert_match /foo\./, @p.io.writer.string
      end
    
      should "present list of available options" do
        @p.ask("foo.", ["bob", "alice"])
        assert_match /1: bob/, @p.io.writer.string
        assert_match /2: alice/, @p.io.writer.string
      end
    
      should "translate response to return value" do
        assert_equal "bar", @p.ask("foo", ["bar"])
      end
    
      should "reprompt on empty response" do
        @p.io.reader.expects(:gets).returns("", "1")
        @p.ask("foo", ["bar"])
        assert_match /\? \?/, @p.io.writer.string
      end
    
      should "reprompt on out-of-range response" do
        @p.io.reader.expects(:gets).returns("7", "1")
        @p.ask("foo", ["bar"])
        assert_match /\? \?/, @p.io.writer.string
      end
    end
    
    context "option: count" do
      setup do
        @p.io.reader.stubs(:gets).returns("")
      end
      
      context "as a number" do
        should "prompt for, and accept, the exact number of selections" do
          @p.io.reader.expects(:gets).times(2).returns("1", "2")
          @p.ask("foo", ["bar", "baz", "qux"], :count => 2)
          assert_match /\? \?/, @p.io.writer.string
        end
        
        should "translate responses into array to return" do
          @p.io.reader.expects(:gets).times(2).returns("1", "2")
          assert_equal ["bar", "baz"], @p.ask("foo", ["bar", "baz", "qux"], :count => 2)
        end
        
        should "accept multiple responses at once" do
          @p.io.reader.expects(:gets).returns("1 2")
          assert_equal ["bar", "baz"], @p.ask("foo", ["bar", "baz", "qux"], :count => 2)
          assert_no_match /\? \?/, @p.io.writer.string
        end
        
        should "ignore extra responses" do
          @p.io.reader.expects(:gets).returns("1 2 3")
          assert_equal ["bar", "baz"], @p.ask("foo", ["bar", "baz", "qux"], :count => 2)
        end
        
        should "re-prompt duplicate responses" do
          @p.io.reader.expects(:gets).returns("1 1 1 1 1 1 3")
          assert_equal ["bar", "qux"], @p.ask("foo", ["bar", "baz", "qux"], :count => 2)
        end
      end
      
      context "as a range" do
        should "prompt for the minimum number of selections" do
          @p.io.reader.expects(:gets).times(2).returns("1", "2")
          @p.ask("foo", ["bar", "baz", "qux"], :count => 2..4)
          assert_match /\? \?/, @p.io.writer.string
        end
          
        should "accept multiple selections in one response" do
          @p.io.reader.expects(:gets).times(2).returns("1 2", "")
          @p.ask("foo", ["bar", "baz", "qux"], :count => 2..4)
          assert_match /\? \?/, @p.io.writer.string
        end
        
        should "translate responses into array to return" do
          @p.io.reader.expects(:gets).returns("1 2")
          assert_equal ["bar", "baz"], @p.ask("foo", ["bar", "baz", "qux"], :count => 2..4)
        end
        
        should "truncate responses to maximum count" do
          @p.io.reader.expects(:gets).returns("1 2 3")
          assert_equal ["bar", "baz"], @p.ask("foo", ["bar", "baz", "qux"], :count => 1..2)
        end
        
        should "return empty array if none selected" do
          @p.io.reader.expects(:gets).returns("")
          assert_equal [], @p.ask("foo", ["bar", "baz", "qux"], :count => 0..3)
        end
        
        should "handle ranges up to infinity" do
          @p.io.reader.expects(:gets).returns("")
          assert_equal [], @p.ask("foo", ["bar", "baz", "qux"], :count => 0..INFINITY)
        end
      end
    end
  end
end
