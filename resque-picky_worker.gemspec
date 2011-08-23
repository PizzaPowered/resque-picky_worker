# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "resque-picky_worker"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Caius Durling"]
  s.email       = ["caius@pizzapowered.com"]
  s.homepage    = "http://pizzapowered.com/"
  s.summary     = %q{Resque worker, but picky about what queues it listens to}
  s.description = %q{Resque worker that evaluates queues and chooses which one to pull jobs from}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.bindir        = "bin"

  s.add_dependency "resque"
  s.add_dependency "resqueue-metadata", "~> 0.0.1"
end
