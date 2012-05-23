module SuperPoller
  autoload :Handler, "super_poller/handler"
  autoload :BufferedHandler, "super_poller/buffered_handler"
  autoload :Router, "super_poller/router"
  autoload :ErrorReporter, "super_poller/error_reporter"
  autoload :StarlingQueue, "super_poller/starling_queue"
  autoload :Poller, "super_poller/poller"
  autoload :AggregatingErrorLogger, "super_poller/aggregating_error_logger"
  autoload :NoneBlockingPoller, "super_poller/none_blocking_poller"
  autoload :QueueUrl, "super_poller/queue_url"
  autoload :QueueIterator, "super_poller/queue_iterator"
  autoload :Stats, "super_poller/stats"
  autoload :RetryWrapper, "super_poller/retry_wrapper"
end
