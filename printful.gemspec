# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'printful/version'

Gem::Specification.new do |gem|
  gem.name          = "printful_api_ruby"
  gem.version       = Printful::VERSION
  gem.authors       = ["Akira Wong"]
  gem.email         = ["akira@awongh.com"]
  gem.description   = %q{A client for the Printful API.}
  gem.summary       = %q{A client for the Printful API.}
  gem.homepage      = "https://github.com/awongh/printful_api_ruby"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday', '~> 2.6.0'

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'vcr'
  
end
