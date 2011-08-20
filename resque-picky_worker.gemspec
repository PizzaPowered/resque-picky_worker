# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "resque-picky_worker"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Caius Durling"]
  s.email       = ["caius@pizzapowered.com"]
  s.homepage    = "http://pizzapowered.com/"
  s.summary     = %q{Chooses a queue }
  s.description = %q{Given a URI to crawl, it'll grab the headers (& contents of only HTML pages) and send that data back to the specified callback URI. Uses curb to be damn quick at what it does.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.bindir        = "bin"

  s.add_dependency "resque"
  s.add_dependency "resqueue-metadata"
end
