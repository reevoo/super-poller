require File.join(File.dirname(__FILE__), "test_helper")

class BufferedHandlerTest < Test::Unit::TestCase
  include SuperPoller
  def self.should_submit_batches_for_messages(args = {})
    context "that receives #{args[:messages]} messages" do
      setup{ args[:messages].times{@handler.call(:your_mum)} }

      before_should "handle #{args[:batches]} batches" do
        @handler.expects(:handle_batch).with([:your_mum] * args[:batch_size]).times(args[:batches])
      end
    end
  end

  context "With a buffered handler with a buffer size of 10" do
    setup{ @handler = Class.new(BufferedHandler){ buffer_size 10 }.new }

    should_submit_batches_for_messages :batch_size => 10, :messages => 0, :batches => 0

    should_submit_batches_for_messages :batch_size => 10, :messages => 9, :batches => 0
    should_submit_batches_for_messages :batch_size => 10, :messages => 10, :batches => 1
    should_submit_batches_for_messages :batch_size => 10, :messages => 11, :batches => 1

    should_submit_batches_for_messages :batch_size => 10, :messages => 19, :batches => 1
    should_submit_batches_for_messages :batch_size => 10, :messages => 20, :batches => 2
    should_submit_batches_for_messages :batch_size => 10, :messages => 21, :batches => 2
  end

  context "With a buffered handler with a buffer size of 8" do
    setup{ @handler = Class.new(BufferedHandler){ buffer_size 8 }.new }

    should_submit_batches_for_messages :batch_size => 8, :messages => 7, :batches => 0
    should_submit_batches_for_messages :batch_size => 8, :messages => 8, :batches => 1

    should_submit_batches_for_messages :batch_size => 8, :messages => 16, :batches => 2
  end

  context "With a buffered handler with a buffer size of 0" do
    setup{ @handler = Class.new(BufferedHandler){ buffer_size 0 }.new }

    should_submit_batches_for_messages :batch_size => 1, :messages => 0, :batches => 0
    should_submit_batches_for_messages :batch_size => 1, :messages => 1, :batches => 1
  end

end
