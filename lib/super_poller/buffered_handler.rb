class SuperPoller::BufferedHandler < SuperPoller::Handler
  class << self
    def buffer_size(size)
      @max_buffer_size = size
    end

    def max_buffer_size
      @max_buffer_size || []
    end
  end

  
  def initialize
    @buffer = []
  end

  def call(msg)
    @buffer.push msg
    if @buffer.size >= self.class.max_buffer_size
      handle_batch @buffer
      @buffer = []
    end
  end

  def handle_batch(batch)
    raise NotImplementedError, "You must define a batch handler."
  end

end
