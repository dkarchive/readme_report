# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'readme_report/version'

Gem::Specification.new do |spec|
  spec.name          = ReadmeReport::PRODUCT
  spec.version       = ReadmeReport::VERSION
  spec.authors       = ['dkhamsing']
  spec.email         = ['dkhamsing8@gmail.com']

  spec.summary       = 'Be a critic'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/readme_report'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = [spec.name]
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'awesome_bot'
  spec.add_runtime_dependency 'github-readme'
  spec.add_runtime_dependency 'colored'
end
