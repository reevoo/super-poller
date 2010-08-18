class SuperPoller::Poller
  def initialize(queue, message_handler, sleep_time = 1)
    @message_handler, @queue, @sleep_time = message_handler, queue, sleep_time
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
  rescue => e
    STDERR.puts "Error while fetching from the queue: #{e.class}: #{e.message}"
    sleep @sleep_time
    retry
  end
end
