# Encoding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sheepit/version'

Gem::Specification.new do |spec|
  spec.name          = 'sheepit'
  spec.version       = Sheepit::VERSION
  spec.authors       = ['Jonathan Hartman']
  spec.email         = %w(j@hartman.io)

  spec.summary       = 'A short description'
  spec.description   = 'A longer description'
  spec.homepage      = 'https://github.com/RoboticCheese/sheepit-ruby'
  spec.license       = 'Apache v2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                         f.match(%r{^(test|spec|features)/})
                       end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
