# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'busser/bats/version'

Gem::Specification.new do |spec|
  spec.name          = 'busser-bats'
  spec.version       = Busser::Bats::VERSION
  spec.authors       = ['Fletcher Nichol']
  spec.email         = ['fnichol@nichol.ca']
  spec.description   = %q{Bats runner plugin for Busser}
  spec.summary       = spec.description
  spec.homepage      = ''
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'busser'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'aruba'

  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'tailor'
  spec.add_development_dependency 'countloc'
end
