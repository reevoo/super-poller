class SuperPoller::Handler
  autoload :TestCase, "super_poller/test_case"
  
  class << self
    def handles(*new_message_names)
      @message_names = (message_names + new_message_names.map{|n| n.to_s}).uniq
    end

    def message_names
      @message_names || []
    end
  end

  def can_handle?(message)
    message["name"] and message["name"] != '' and self.class.message_names.include? message["name"].to_s
  end

  def call(message)
    raise NotImplementedError, "You must define a call handler."
  end

end
