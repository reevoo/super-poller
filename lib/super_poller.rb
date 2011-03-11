module SuperPoller
  autoload :ErrorReporter, "super_poller/error_reporter"
  autoload :GenericQueue, "super_poller/generic_queue"
  autoload :StarlingQueue, "super_poller/starling_queue"
  autoload :JsonFormattedQueue, "super_poller/json_formatted_queue"

  autoload :Poller, "super_poller/poller"
  autoload :Router, "super_poller/router"
  autoload :Handler, "super_poller/handler"
  autoload :BufferedHandler, "super_poller/buffered_handler"

  autoload :AggregatingErrorLogger, "super_poller/aggregating_error_logger"
  autoload :NoneBlockingPoller, "super_poller/none_blocking_poller"
  autoload :QueueUrl, "super_poller/queue_url"
  autoload :QueueItterator, "super_poller/queue_itterator"
  autoload :Stats, "super_poller/stats"
  autoload :RetryWrapper, "super_poller/retry_wrapper"
end
