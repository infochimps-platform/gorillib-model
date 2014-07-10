# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gorillib/model/version'

Gem::Specification.new do |gem|
  gem.name          = 'gorillib-model'
  gem.version       = Gorillib::Model::VERSION
  gem.authors       = %w[ Infochimps ]
  gem.email         = 'coders@infochimps.com'
  gem.homepage      = 'https://github.com/infochimps-labs/weavr.git'
  gem.licenses      = ['Apache 2.0']
  gem.summary       = 'Fully-featured Ruby model library'
  gem.description   = <<-DESC.gsub(/^ {4}/, '').chomp
    Gorillib::Model    
  DESC

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = %w[ lib ]

  gem.add_development_dependency('bundler', '~> 1.6.3')

  gem.add_dependency('multi_json',    '~> 1.10.1')
  gem.add_dependency('activesupport', '~> 4.1.4')
  gem.add_dependency('addressable',   '~> 2.3.6')
end
