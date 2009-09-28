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
end
