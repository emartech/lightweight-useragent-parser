# [lightweight-useragent-parser][![Build Status][travis-image]][travis-link]

[travis-image]: https://travis-ci.org/emartech/lightweight-useragent-parser.svg?branch=master
[travis-link]: https://travis-ci.org/emartech/lightweight-useragent-parser
[travis-home]: http://travis-ci.org/

Very lightweight user agent parser with the aim of detecting mobile devices and identifying main device platforms.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lightweight-useragent-parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lightweight-useragent-parser

## Usage

```ruby
  ua = LightweightUseragentParser.new "Mozilla/5.0 (Linux; Android 4.4.2; SGP512 Build/17.1.1.A.0.402) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.44 Safari/537.36"
  p ua.to_hash
```

## Contributing

1. Fork it ( https://github.com/emartech/lightweight-useragent-parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
