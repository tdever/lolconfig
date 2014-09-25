#!/usr/bin/ruby

require "yaml"
#require "pry"

module Lolconfig

	class Config

		#Creates a new configuration object with the specified options.
		def initialize(options = nil)
			@config = options ? options : {}
		end

		#Loads the configuration settings from the specified file.
		def load(filename)
			raise ArgumentError.new unless filename

			options = YAML::load(IO.read(filename))
			if(options)
				self.configure(options)
			end
		end

		#Gets the configuration value at the specified key.
		def get(key)
			return @config[key]
		end

		#Gets a hash of the current key/value pairs.
		def get_hash()
			return @config.clone()
		end

		#Gets the configuration keys that are currently set.
		def get_keys()
			return @config.keys
		end

		#Gets the current configuration values.
		def get_values()
			return @config.values
		end

		#Removes the specified configuration setting.
		def remove(key)
			value = @config.shift(key)
			return value
		end

		#Sets the specified configuration setting or group of settings. If key is a Hash, the contained values are added or updated on this object.
		#Params:
		#+key+:: Setting name or hash containing multiple setting objects.
		#+value+:: Setting value. This value is ignored if a hash is passed as the first parameter.
		def set(key, value = nil)
			return unless key

			if (!value && key.instance_of?(Hash))
				key.each { |k, v|
					@config[k] = v
				}
			else
				@config[key] = value
			end
		end

	end

end
