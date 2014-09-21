# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolconfig/version'

Gem::Specification.new do |spec|
  spec.name          = "lolconfig"
  spec.version       = Lolconfig::VERSION
  spec.authors       = ["Tim Dever"]
  spec.email         = ["tdever@users.noreply.github.com"]
  spec.summary       = %q{lolconfig is a lightweight way to configure your ruby app.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #dependencies
  spec.add_dependency "yaml", "~> 2.0"

  #development dependencies
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
