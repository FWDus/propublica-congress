# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "propublica_congress/version"

Gem::Specification.new do |s|
  s.name        = 'propublica_congress'
  s.version     = PropublicaCongress::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sheridan Gray"]
  s.email       = 'sheridan@fwd.us'
  s.summary     = "A simple Ruby wrapper for the Propublica Congress API"
  s.description = "https://propublica.github.io/congress-api-docs/#congress-api-documentation"
  s.homepage    =
    'https://propublica.github.io/congress-api-docs/#congress-api-documentation'
  s.license       = 'MIT'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end