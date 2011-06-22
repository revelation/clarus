# -*- encoding: utf-8 -*-
require File.expand_path("../lib/clarus/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "clarus"
  s.version     = Clarus::VERSION
  s.authors     = ["Dan Herrera"]
  s.email       = ["dan@revelationglobal.com"]
  s.homepage    = ""
  s.summary     = %q{Clarus is a way to create documents programmatically. Moof!}
  s.description = %q{Clarus makes a jruby wrapper around the java2word library to create documents.}

  s.rubyforge_project = "clarus"

  s.add_dependency 'json'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'jruby-openssl'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
