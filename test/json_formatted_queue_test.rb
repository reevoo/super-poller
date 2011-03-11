require File.join(File.dirname(__FILE__), "test_helper")

class JsonFormattedQueueTest < Test::Unit::TestCase
  def test_should_jsonize_on_push
    @queue = []
    @json_queue = SuperPoller::JsonFormattedQueue.new(@queue)
    @json_queue.push(:one => 1, :two => 2)
    assert_equal String, @queue.first.class
    assert_equal( {"one" => 1, "two" => 2}, JSON.parse(@queue.first))
  end

  def test_should_un_jsonize_on_pop
    @json_queue = SuperPoller::JsonFormattedQueue.new([])
    @json_queue.push(:one => 1, :two => 2)
    assert_equal( {"one" => 1, "two" => 2}, @json_queue.pop)
  end

  def test_should_un_jsonize_on_fetch
    queue = []
    def queue.fetch; shift; end
    @json_queue = SuperPoller::JsonFormattedQueue.new(queue)
    @json_queue.push(:one => 1, :two => 2)
    assert_equal( {"one" => 1, "two" => 2}, @json_queue.fetch)
  end
  
  def test_should_return_non_json_data_on_pop_but_json_it_back_and_forth_first
    @json_queue = SuperPoller::JsonFormattedQueue.new([{:one => 1, :two => 2}])
    assert_equal( {"one" => 1, "two" => 2}, @json_queue.pop)
  end
end