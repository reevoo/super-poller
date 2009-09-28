require File.join(File.dirname(__FILE__), "test_helper")

class PollerTest < Test::Unit::TestCase
  include SuperPoller
  
  def setup
    @queue = Queue.new
    @message_handler = stub("message_handler")
    @poller = Poller.new(@queue, @message_handler)
  end
  
  should "pull things from the queue to the message_handler" do
    @queue.push "Oh Hi!"
    @message_handler.expects(:call).with("Oh Hi!").once
    @poller.poll
  end

  should "pull more than one thing from the queue to the message_handler" do
    @queue.push "First"
    @queue.push "Second"

    @message_handler.expects(:call).with("First").once
    @message_handler.expects(:call).with("Second").once
    
    2.times{ @poller.poll }
  end
end
