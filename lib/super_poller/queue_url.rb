require "uri"

class SuperPoller::QueueUrl < URI::Generic
  def self.parse(url)
    url = "starling://localhost:22122/#{url}" if url =~ /^[a-zA-Z0-9_-]+$/
    new(*URI.parse(url).send(:component_ary))
  end

  def to_queue
    raise URI::InvalidURIError unless respond_to? "to_#{scheme}_queue"
    send("to_#{scheme}_queue")
  end

protected
  def to_starling_queue
    SuperPoller::StarlingQueue.new(path, "#{host}:#{port}")
  end
end
