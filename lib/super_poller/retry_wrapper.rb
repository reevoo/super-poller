class SuperPoller::RetryWrapper
  def initialize(&block)
    @builder = block
  end

protected
  def wrapped_queue
    @queue ||= @builder.call
  end

  def reset_wrapped_queue!
    @queue = nil
  end

  def method_missing(*args)
    wrapped_queue.send(*args)
  rescue RuntimeError => e
    reset_wrapped_queue!
    raise
  end
end
