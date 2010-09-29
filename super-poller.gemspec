Gem::Specification.new do |s|
  s.name = 'super-poller'
  s.version = '0.2.2'
  s.authors = ['Tom Lea', 'George Brocklehurst']
  s.date = '2010-07-27'
  s.description = 'Small modular library for dealing with queues and pollers.'
  s.email = 'contrib@tomlea.co.uk'
  s.executables = ['queue']
  s.files = Dir.glob('{bin,lib,test}/**/*') + ['Rakefile']
  s.homepage = 'http://tomlea.co.uk/'
  s.summary = 'Tools for dealing with queues.'
end
