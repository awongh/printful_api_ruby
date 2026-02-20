# frozen_string_literal: true

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'printful/version'

Gem::Specification.new do |gem|
  gem.name          = 'printful_api_ruby'
  gem.version       = Printful::VERSION
  gem.authors       = ['Akira Wong']
  gem.email         = ['akira@awongh.com']
  gem.description   = 'A client for the Printful API.'
  gem.summary       = 'A client for the Printful API.'
  gem.homepage      = 'https://github.com/awongh/printful_api_ruby'
  gem.required_ruby_version = ['>= 3.4', '< 5']

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'faraday', '~> 2.0'

  gem.add_development_dependency 'dotenv'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
