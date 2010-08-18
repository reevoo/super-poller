class SuperPoller::Stats
  def initialize(router, out = STDERR, interval = 60)
    @router = router
    @out = out
    @semaphore = Mutex.new
    @interval = interval
    reset
    ensure_worker_is_running
  end

  def ensure_worker_is_running
    return if @worker && @worker.alive?
    @worker.join if @worker

    @worker = Thread.start{
      Thread.abort_on_exception = true
      while true
        flush
        sleep(@interval)
      end
    }
  end

  def call(msg)
    ensure_worker_is_running
    @semaphore.synchronize do
      begin
        name = msg[:name]
        @counts[name] += 1
        start_time = Time.now
        @router.call(msg)

      ensure
        end_time = Time.now
        duration = end_time.to_f - start_time.to_f
        @durations[name] << duration
      end
    end
  end

protected

  def reset
    @counts = Hash.new(0)
    @durations = Hash.new{|h,k| h[k] = []}
  end

  def flush
    @semaphore.synchronize do
      if use_atomic_write?
        f = Tempfile.open("queue_stats", File.dirname(@out) )
      else
        f = @out
      end

      f.puts Time.now.to_s
      @counts.each do |name, count|
        durations = @durations[name]
        f.puts "#{name}: #{count} messages, mean: #{durations.sum/count}s, min: #{durations.min}s, max: #{durations.max}s"
      end

      if use_atomic_write?
        f.close
        File.unlink(@out) if File.exists?(@out)
        File.link(f.path, @out)
      end
      reset
    end
  end

  def use_atomic_write?
    ! @out.is_a?( IO )
  end
end
