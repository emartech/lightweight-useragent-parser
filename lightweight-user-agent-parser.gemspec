# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lightweight_user_agent_parser/version'

Gem::Specification.new do |spec|

  spec.name          = 'lightweight_user_agent_parser'
  spec.version       = "#{LightweightUserAgentParser::VERSION}"

  spec.license       = 'MIT License'
  spec.authors       = ['Emarsys Technologies','Peter Kozma','Adam Luzsi']
  spec.email         = %W[ peter.kozma@emarsys.com aluzsi@emarsys.com ]

  spec.homepage      = 'https://github.com/emartech/lightweight-useragent-parser'
  spec.summary       = %q{Very lightweight user agent parser with the aim of detecting mobile devices and identifying main device platforms.}
  spec.description   = %q{Very lightweight user agent parser with the aim of detecting mobile devices and identifying main device platforms.}

  spec.files         = `git ls-files -z`.split("\x0").select{|path| !(path =~ /spec\/data/i) }

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'   , '>= 3'
  spec.add_development_dependency 'rake'

end
