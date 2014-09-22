require "logger"
require "yaml"
require "./lolconfig/version"
require "./lolconfig/config"

require "pry"

#http://stackoverflow.com/questions/6233124/where-to-place-access-config-file-in-gem

module Lolconfig

	CONFIG_DEFAULT_FILENAME = "config.yaml"		#Default config file name
	CONFIG_DEFAULT_NAME = "default"			#Default configuration name


	# Hash containing the available configuration objects
	@configs = Hash.new()
	@default_config = nil


	# Initialize the logger
	@log = Logger.new(STDOUT)
	@log.level = Logger::WARN


	#Gets the specified configuration setting
	#Params:
	#+key+:: Setting name.
	#+name+:: Configuration name.
	def self.get(key, name = nil)
		cfg = name ? @configs[name] : @default_config
		if cfg
			return cfg.get(key)
		end

		return nil
	end

	#Returns a Hash of the current configuration settings.
	#Params:
	#+name+::Configuration name. This method gets the default configuration if this argument is not specified.
	def self.get_config(name = nil)
		cfg = name ? @configs[name] : @default_config
		if cfg
			return cfg.get_hash()
		end

		return nil
	end
	

	#Loads the default configuration file from the current working directory.
	def self.load()
		name = CONFIG_DEFAULT_FILENAME
		if(File.extname(name) != "yaml")
			name = name + ".yaml"
		end

		#TODO: Enable loading multiple config files for different configurations based on sub directory names or
		#file names like "config.yaml", "config.debug.yaml", "config.win32.yaml", etc.
		if File.exists? name
			self.load_file(filename)
		else
			@log.warn("Config file \"{name}\" not found.")
		end
	end

	#Loads the specified configuration file. Optionally, a configuration name can be specified.
	#Params:
	#+filename+:: File name.
	#+name+:: Configuration name. If not specified, the default configuration is used.
	def self.load_file(filename, name = CONFIG_DEFAULT_NAME)
		return unless filename

		begin
			options = YAML::load(IO.read(filename))

			cfg = @configs[name]
			if cfg
				cfg.configure(options)
			else
				cfg = Config.new(options)	
			end

		rescue Errno::ENOENT
			@log.warn("Configuration file not found.")
		rescue Psych::SyntaxError
			@log.warn("YAML file contains invalid syntax.")
		end
	end

	#Sets the specified configuration options. Optionally, a configuration name can be specified.
	#Params:
	#+options+:: Configuration options.
	#+name+:: Configuration name. If not specified, the default configuration is used.
	def self.set(options = {}, name = nil)
		cfg = name ? @configs[name] : @default_config

		if cfg
			cfg.set(options)
		else
			cfg = Config.new(options)
			if !name
				@default_config = cfg
				@configs[CONFIG_DEFAULT_NAME] = cfg
			else
				@configs[name] = cfg
			end
		end
	end


	#some tests
	

	binding.pry

	self.set({
		:test1 => "hello",
		:test2 => "world!"
	})

	self.set({
		:test3 => "Goodbye",
		:test4 => "world!"
	}, "default")


	self.load()


	if @configs
		@configs.each { |k, v|
			if v
				v.get_keys().each { |k|
					puts v.get(k)	
				}
			end
		}
	end

end


