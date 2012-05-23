class SuperPoller::QueueIterator
  def initialize(queue)
    @queue = queue
  end

  def each(&block)
    @memo = {:memo => Time.now.to_f}
    @queue.push @memo
    while @memo
      begin
        break unless msg = @queue.fetch
        if msg == @memo
          msg = @memo = nil
        else
          msg = nil if :delete == block.call(msg)
        end
      ensure
        @queue.push msg if msg
      end
    end
  ensure
    destroy_the_memo
  end

  def destroy_the_memo
    while @memo and msg = @queue.fetch and msg != @memo
      @queue.push(msg)
    end
  end
end
