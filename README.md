# Lolconfig

Lolconfig is a lightweight way to configure your ruby app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lolconfig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lolconfig

## Usage

Require this gem in your application:

```ruby
require "lolconfig"
```

Load the configuration from a YAML file or specify your own hash of key value pairs:

```ruby
#Loads the default configuration file ("config.yaml")
Lolconfig::load()

#Specify a hash of key/value pairs
Lolconfig::set({ :item1 => "value1", :item2 => "value2" })
```

Retrieve configuration settings by requesting the setting name.

```ruby
my_setting = Lolconfig::get("my_setting")
puts my_setting
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lolconfig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
