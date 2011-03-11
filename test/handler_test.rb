require File.join(File.dirname(__FILE__), "test_helper")

class HandlerTest < Test::Unit::TestCase
  include SuperPoller

  context "With handlers for :foo and :bar messages" do
    setup do
      @foo_handler = Class.new(Handler){ handles :foo }.new
      @bar_handler = Class.new(Handler){ handles :bar }.new
    end

    should "only foo_handler should handle a message named :foo" do
      assert @foo_handler.can_handle?({"name" => "foo"})
      assert !@bar_handler.can_handle?({"name" => "foo"})
    end

    should "only bar_handler should handle a message named :bar" do
      assert !@foo_handler.can_handle?({"name" => "bar"})
      assert @bar_handler.can_handle?({"name" => "bar"})
    end

    should "accept strings or symbols as names" do
      assert @foo_handler.can_handle?({"name" => :foo})
    end

  end
  
end
