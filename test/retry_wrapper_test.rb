require File.join(File.dirname(__FILE__), "test_helper")

class RetryWrapperTest < Test::Unit::TestCase
  include SuperPoller

  context "A RetryWrapper wraped around a queue" do
    setup do
      @queue_factory = stub(:queue_factory)
      @queue = stub("Queue", :pop => "Fish")
      @raiser_queue = stub("Queue")
      @raiser_queue.stubs(:pop).raises(RuntimeError)
      @wrapper = RetryWrapper.new{ @queue_factory.build }
    end

    should "delegate pop to a new queue from the queue factory" do
      @queue_factory.expects(:build).returns(@queue).once
      assert_equal "Fish", @wrapper.pop
      assert_equal "Fish", @wrapper.pop
    end

    should "create a new queue using the factory if the first one raises" do
      @queue_factory.expects(:build).returns(@raiser_queue).twice
      assert_raise(RuntimeError){ @wrapper.pop }
      assert_raise(RuntimeError){ @wrapper.pop }
    end
  end
end
