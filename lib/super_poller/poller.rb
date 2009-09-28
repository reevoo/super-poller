class SuperPoller::Poller
  def initialize(queue, message_handler)
    @message_handler, @queue = message_handler, queue
  end

  def poll
    @message_handler.call(get_message)
  end

  def start!
    poll while true
  end

protected
  def get_message
    @queue.pop
  rescue Interrupt
    raise
  rescue Object => e
    STDERR.puts "Error while fetching from the queue: #{e.class}: #{e.message}"
    sleep 10
    retry
  end
end
