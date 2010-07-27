class SuperPoller::ErrorReporter
  def initialize(message_handler, error_handler = nil, &block)
    @message_handler = message_handler
    @error_handler = error_handler || block
  end
  
  def call(*args)
    @message_handler.call(*args)
  rescue StandardError => e
    @error_handler.call(e, *args)
  end
end
