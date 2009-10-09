require "rubygems"
require "rake/gempackagetask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

spec = Gem::Specification.new do |s|
  s.name              = "super-poller"
  s.version           = "0.1.0"
  s.summary           = "Tools for dealing with queues."
  s.description       = "Small modular library for dealing with queues and pollers."
  s.author            = "Tom Lea"
  s.email             = "contrib@tomlea.co.uk"
  s.homepage          = "http://tomlea.co.uk"
  s.has_rdoc          = true

  s.files             = %w(Rakefile super_poller.gemspec) + Dir.glob("{bin,test,lib}/**/*")
  s.executables       = FileList["bin/*"].map { |f| File.basename(f) }

  s.require_paths     = ["lib"]
  s.rubyforge_project = "super-poller"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end
