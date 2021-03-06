Gem::Specification.new do |s|
  s.name = 'super-poller'
  s.version = '1.0.0'
  s.authors = ['Tom Lea', 'George Brocklehurst']
  s.date = '2012-05-23'
  s.description = 'Small modular library for dealing with queues and pollers.'
  s.email = 'contrib@tomlea.co.uk'
  s.executables = ['queue']
  s.files = Dir.glob('{bin,lib,test}/**/*') + ['Rakefile']
  s.homepage = 'http://tomlea.co.uk/'
  s.summary = 'Tools for dealing with queues.'
  s.add_dependency "multi_json"
end
