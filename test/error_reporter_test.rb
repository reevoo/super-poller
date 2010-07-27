require File.join(File.dirname(__FILE__), "test_helper")

class ErrorReporterTest < Test::Unit::TestCase
  include SuperPoller
  
  should "catch errors and report them to the provided error handler" do
    has_caught = false
    raiser = proc{|msg| raise "Error doing a #{msg}" }
    handler = proc{|e, message| has_caught = (e.message == "Error doing a Hello" and message == "Hello") }

    ErrorReporter.new(raiser, handler).call("Hello")

    assert has_caught
  end

  should "catch errors and report them to the provided error handling block" do
    has_caught = false
    raiser = proc{|msg| raise "Error doing a #{msg}" }

    ErrorReporter.new(raiser){|e, message| has_caught = (e.message == "Error doing a Hello" and message == "Hello") }.call("Hello")

    assert has_caught
  end

  should "not catch errors that do not inherit from StandardError" do
    raiser = proc{|msg| raise Exception, "Error doing a #{msg}" }

    assert_raise(Exception) do
      ErrorReporter.new(raiser){ flunk }.call("Hello")
    end
  end

  should "not catch errors if they don't happen" do
    ErrorReporter.new(stub("handler", :call)){|*args| flunk "Should not have tried to raise!" }.call("Hello")
  end
end
