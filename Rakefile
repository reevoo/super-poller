require "rubygems"
require "rake/gempackagetask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

Rake::GemPackageTask.new(eval(File.read('super-poller.gemspec'))){ }
