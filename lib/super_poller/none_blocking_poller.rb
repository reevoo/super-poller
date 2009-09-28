class SuperPoller::NoneBlockingPoller < SuperPoller::Poller
  EmptyQueue = Class.new(Exception)

  def start!
    super
  rescue EmptyQueue
  end

protected
  def get_message
    @queue.fetch or raise EmptyQueue
  end
end
