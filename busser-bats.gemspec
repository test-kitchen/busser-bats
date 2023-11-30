# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "busser/bats/version"
require "English"

Gem::Specification.new do |gem|
  gem.name          = "busser-bats"
  gem.version       = Busser::Bats::VERSION
  gem.authors       = ["Fletcher Nichol"]
  gem.email         = ["fnichol@nichol.ca"]
  gem.description   = "A Busser runner plugin for Bats"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/test-kitchen/busser-bats"
  gem.license       = "Apache 2.0"

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = []
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "busser"
end
