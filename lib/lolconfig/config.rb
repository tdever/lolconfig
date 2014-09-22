#!/usr/bin/ruby

require "yaml"
require "pry"


module Lolconfig

	class Config

		def initialize(options)
			@config = options ? options : {}
		end

		def configure(options)
			binding.pry
			return unless options

			#merge the configuration options
			options.each { |k, v|
				@config[k] = v
			}
		end

		def load_from_file(filename)
			raise ArgumentError.new unless filename

			options = YAML::load(IO.read(filename))
			if(options)
				self.configure(options)
			end
		end

		def get(key)
			return @config[key]
		end

		def get_keys()
			return @config.keys
		end

		def get_values()
			return @config.values
		end

		def set(key, value)
			@config[key] = value
		end

	end

end
