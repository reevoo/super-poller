require "starling"

class SuperPoller::StarlingQueue
  def initialize(queue_name, *args)
    @queue_name = queue_name.to_s
    @queue = Starling.new(*args)
  end

  def pop
    @queue.get(@queue_name)
  end

  def push(v)
    @queue.set(@queue_name, v)
  end

  def fetch
    @queue.fetch(@queue_name)
  end

  def length
    @queue.sizeof(@queue_name)
  end

  def empty?
    length.zero?
  end

  def any?
    !empty?
  end

  def flush
    @queue.delete(@queue_name)
  end
end
