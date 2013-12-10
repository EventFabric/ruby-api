# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventfabric/version'

Gem::Specification.new do |spec|
  spec.name          = "eventfabric"
  spec.version       = EventFabric::VERSION
  spec.authors       = ["Javier Dall' Amore"]
  spec.email         = ["javier@event-fabric.com"]
  spec.description   = %q{Event Fabric Client API}
  spec.summary       = %q{ef client api to send events}
  spec.homepage      = "http://event-fabric.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
