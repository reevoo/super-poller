require "rubygems"
require "rubygems/package_task"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

Gem::PackageTask.new(eval(File.read('super-poller.gemspec'))){ }
