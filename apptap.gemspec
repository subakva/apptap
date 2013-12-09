# -*- encoding: utf-8 -*-
require File.expand_path('../lib/apptap/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Jason Wadsworth']
  gem.email         = ['jdwadsworth@gmail.com']
  gem.description   = %q{AppTap makes it easy to manage service dependencies for your apps. It uses an app-local installation of homebrew to install services, and foreman to manage service processes.}
  gem.summary       = %q{Simplifies management of service dependencies for development. }
  gem.homepage      = 'https://github.com/subakva/apptap'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'apptap'
  gem.require_paths = ['lib']
  gem.version       = AppTap::VERSION

  gem.add_dependency('thor')
  gem.add_dependency('foreman')

  gem.add_development_dependency('rake', ['~> 10.1.0'])
  gem.add_development_dependency('rspec', ['~> 2.14.0'])
  gem.add_development_dependency('awesome_print', ['~> 1.2.0'])
  # gem.add_development_dependency('simplecov', ['~> 0.6.2'])
  # gem.add_development_dependency('cane', ['~> 1.3.0'])
  # gem.add_development_dependency('yard', ['~> 0.7.5'])
  # gem.add_development_dependency('yard-tomdoc', ['~> 0.4.0'])
  # gem.add_development_dependency('redcarpet', ['~> 2.1.1'])
  # gem.add_development_dependency('ruby-debug19', ['~> 0.11.6'])
end
