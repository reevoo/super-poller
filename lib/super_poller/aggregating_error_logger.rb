class SuperPoller::AggregatingErrorLogger
  def initialize(stats_file, queue)
    @stats_file, @queue = stats_file, queue
  end

  def call(error, failed_message)
    update_error_queue(error, failed_message)
    update_error_stats(error, failed_message[:name] || :unknown)
  end

protected
  def update_error_queue(error, failed_message)
    error_class_name = error.class.name.to_sym
    error_description = {:class => error_class_name, :message => error.message}
    @queue.push(failed_message.merge(:error => error_description))
  end

  def update_error_stats(error, message_name)
    stats = load_stats
    error_class_name = error.class.name.to_sym
    stats_for_name = (stats[message_name] ||= {})
    stats_for_name[error_class_name] ||= 0
    stats_for_name[error_class_name] += 1

    File.open(@stats_file, "w") do |file|
      file << YAML.dump(stats)
    end
  end

  def load_stats
    File.exists?(@stats_file) && YAML.load(File.read(@stats_file)) || {}
  end
end
