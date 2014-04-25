# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bk/gem/minitest/version'

Gem::Specification.new do |spec|
  spec.name        = 'bk-gem-minitest'
  spec.version     = BK::Gem::Minitest::VERSION
  spec.authors     = ['Kimberley Scott']
  spec.email       = ['kscott@localdirectories.com.au']
  spec.summary     = %q{MiniTest, cane and reek tasks provided for free}
  spec.description = %q{MiniTest, cane and reek tasks provided for free}
  spec.homepage    = ''
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'activesupport', '>= 4.0'
  spec.add_runtime_dependency 'cane'
  spec.add_runtime_dependency 'minitest'
  spec.add_runtime_dependency 'minitest-reporters'
  spec.add_runtime_dependency 'minitest-stub_any_instance'
  spec.add_runtime_dependency 'reek'
  spec.add_runtime_dependency 'awesome_print'
  spec.add_runtime_dependency 'rack-test'
  spec.add_runtime_dependency 'simplecov'

end
