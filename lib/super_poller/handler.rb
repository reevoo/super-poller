class SuperPoller::Handler
  autoload :TestCase, "super_poller/test_case"
  
  class << self
    def handles(*new_message_names)
      @message_names = (message_names + new_message_names).uniq
    end

    def message_names
      @message_names || []
    end
  end

  def can_handle?(message)
    self.class.message_names.include? message[:name].to_sym
  end

  def call(message)
    raise NotImplementedError, "You must define a call handler."
  end

end
