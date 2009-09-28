# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{super_poller}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Your name"]
  s.date = %q{2009-09-28}
  s.email = %q{you@example.com}
  s.files = ["test/aggregating_error_logger_test.rb", "test/buffered_handler_test.rb", "test/error_reporter_test.rb", "test/handler_test.rb", "test/poller_test.rb", "test/router_test.rb", "test/starling_queue_test.rb", "test/test_helper.rb", "lib/super_poller", "lib/super_poller/aggregating_error_logger.rb", "lib/super_poller/buffered_handler.rb", "lib/super_poller/error_reporter.rb", "lib/super_poller/handler.rb", "lib/super_poller/poller.rb", "lib/super_poller/router.rb", "lib/super_poller/starling_queue.rb", "lib/super_poller/test_case.rb", "lib/super_poller.rb"]
  s.homepage = %q{http://example.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{What this thing does}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
