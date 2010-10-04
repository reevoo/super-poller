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
  rescue MemCache::MemCacheError => e
    if e.message =~ /bad command line format/
      STDERR.puts "WARNING: Server could not handle delete command. Falling back to the MUCH slower, and quite unreliable flush method. Consider using Reevoo Starling (http://github.com/reevoo/starling)"
      @queue.flush(@queue_name)
    else
      raise
    end
  end
end
