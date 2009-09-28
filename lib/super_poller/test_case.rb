class SuperPoller::Handler::TestCase < (defined?(ActiveSupport::TestCase) ? ActiveSupport::TestCase : Test::Unit::TestCase)

  def handler
    @handler ||= self.class.name.gsub(/Test$/, "").constantize.new
  end

  def self.should_handle(name)
    should "handle a #{name.inspect} message" do
      assert handler.can_handle?(:name => name)
    end
  end

end
