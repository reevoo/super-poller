require File.join(File.dirname(__FILE__), "test_helper")

class RouterTest < Test::Unit::TestCase
  include SuperPoller

  context "With a router that has two handlers" do

    setup do
      @router = Router.new
      @foo_handler = Class.new(Handler){ handles :foo }.new
      @bar_handler = Class.new(Handler){ handles :bar }.new
      @router << @foo_handler << @bar_handler
    end
    
    should "route foo messages to the correct handler" do
      @foo_handler.expects(:call).with("test body").once
      @bar_handler.expects(:call).never
      @router.call({"name" => "foo", "body" => "test body"})
    end

    should "route bar messages to the correct handler" do
      @foo_handler.expects(:call).never
      @bar_handler.expects(:call).with("test body").once
      @router.call({"name" => "bar", "body" => "test body"})
    end

    should "raise RoutingError if handler not found" do
      assert_raise(Router::RoutingError){ @router.call("name" => "your_mum") }
    end

  end
end
