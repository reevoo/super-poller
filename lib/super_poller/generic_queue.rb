class SuperPoller::GenericQueue
  def empty?
    length.zero?
  end

  def any?
    !empty?
  end

  def pop
    while true
      if v = fetch
        return v
      else
        sleep 0.2
      end
    end
  end

  def push(v)
    raise NotImplemented
  end

  def fetch
    raise NotImplemented
  end

  def length
    raise NotImplemented
  end

  def flush
    while fetch; end
  end
end