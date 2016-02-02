# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/lightweight_useragent_parser/version'

Gem::Specification.new do |spec|

  spec.name          = 'lightweight-useragent-parser'
  spec.version       = "#{LightweightUseragentParser::VERSION}"

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

  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'   , '>= 3'
  spec.add_development_dependency 'rake'

end
