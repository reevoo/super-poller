require File.join(File.dirname(__FILE__), "test_helper")

class StarlingQueueTest < Test::Unit::TestCase
  include SuperPoller

  STARLING_QUEUE_PATH = '/tmp/reevoo_superpoller_starling'
  STARLING_PID_PATH = '/tmp/reevoo_superpoller_starling.pid'
  STARLING_PORT = '13891'

  context "with a running starling" do
    setup do
      FileUtils.rm_r STARLING_QUEUE_PATH if File.exists? STARLING_QUEUE_PATH
      FileUtils.rm_r STARLING_PID_PATH if File.exists? STARLING_PID_PATH
      system("starling -p #{STARLING_PORT} -P #{STARLING_PID_PATH} -q #{STARLING_QUEUE_PATH} -d 2>&1")
      sleep 1
    end

    teardown do
      system("kill -9 `cat #{STARLING_PID_PATH}`")
    end

    should "write to and read from a queue in the correct order" do
      queue = StarlingQueue.new("TEST_QUEUE", ["localhost:#{STARLING_PORT}"])
      queue.push("first")
      queue.push("second")
      assert_equal "first", queue.pop
      assert_equal "second", queue.pop
    end

  end

end
