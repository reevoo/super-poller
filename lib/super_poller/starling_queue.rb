require "starling"
require "multi_json"

class SuperPoller::StarlingQueue
  def initialize(queue_name, *args)
    @queue_name = queue_name.to_s
    @queue = Starling.new(*args)
  end

  def pop
    coerce @queue.get(@queue_name, true)
  end

  def push(v, raw = false)
    @queue.set(@queue_name, v, 0, raw)
  end

  def fetch
    coerce @queue.fetch(@queue_name, true)
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

  if "".respond_to? :force_encoding
    def fix_encoding(v)
      v.force_encoding('UTF-8')
    end
  else
    def fix_encoding(v)
      v
    end
  end

  def coerce(message)
    unless message.start_with?('{')
      message = MultiJson.dump(Marshal.load(message))
    end
    message = fix_encoding(message)
    MultiJson.decode(message)
  end
end
