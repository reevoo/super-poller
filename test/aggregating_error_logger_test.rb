require File.join(File.dirname(__FILE__), "test_helper")


class AggregatingErrorLoggerTest < Test::Unit::TestCase
  include SuperPoller
  attr_reader :queued_message

  def log_contents
    YAML.load(File.open(@path))
  end

  context "With an error logger" do
    setup do
      @log_file = Tempfile.new("AggregatingErrorLoggerTest")
      @path = @log_file.path
      @queue = Queue.new
      @logger = AggregatingErrorLogger.new(@path, @queue)
    end

    context "with a exception and message passed in, it" do
      setup do
        @exception = Exception.new("The house is on fire")
        @message = {:name => :foo, :body => "hello"}
        @logger.call(@exception, @message)
        @queued_message = @queue.pop(nonblocking = true)
      end

      should "add errors to the error queue" do
        assert_equal :foo, queued_message[:name]
        assert_equal "hello", queued_message[:body]
      end

      should "add error info to the queued message" do
        assert_equal( {:class => :Exception, :message => "The house is on fire"}, queued_message[:error])
      end

      should "log errors to the log file" do
        assert_equal( {:foo  => {:Exception => 1} }, log_contents)
      end

      should "aggregate duplicate errors" do
        @logger.call(@exception, @message)
        assert_equal( {:foo  => {:Exception => 2} }, log_contents)
      end

      should "separate different exceptions" do
        @logger.call(ArgumentError.new(""), @message)
        assert_equal( {:foo  => {:Exception => 1, :ArgumentError => 1} }, log_contents)
      end

      should "separate errors for different message names" do
        @logger.call(@exception, {:name => :bar, :body => "hello"})
        assert_equal( {:foo => {:Exception => 1}, :bar => {:Exception => 1} }, log_contents)
      end

      should "reset the counts to 0 if we delete the log file" do
        assert_equal( {:foo  => {:Exception => 1} }, log_contents)
        File.delete(@path)
        @logger.call(@exception, {:name => :bar, :body => "hello"})
        assert_equal( {:bar  => {:Exception => 1} }, log_contents)
      end

    end
  end
end
