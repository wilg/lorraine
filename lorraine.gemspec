# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lorraine/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Wil Gieseler"]
  gem.email         = ["supapuerco@gmail.com"]
  gem.description   = %q{How else are you going to communicate with an LED wall?}
  gem.summary       = %q{How else are you going to communicate with an LED wall?}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "lorraine"
  gem.require_paths = ["lib"]
  gem.version       = Lorraine::VERSION
end
