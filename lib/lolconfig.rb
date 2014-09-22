require "yaml"
require "./lolconfig/version"
require "./lolconfig/config"

require "pry"

module Lolconfig	

	binding.pry

	@configs = {
	}	


	def self.set_config(options = {}, name = "default")
		binding.pry
		
		cfg = @configs[name]
		if cfg
			cfg.configure(options)
		else
			@configs[name] = Config.new(options)
		end
	end

	def self.load(path)

	end

	def self.load_file(filename, name = "default")
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
			log(:warning, "Configuration file not found.")
		rescue Psych::SyntaxError
			log(:warning, "YAML file contains invalid syntax.")
		end
	end


	#some tests
	
	
	self.set_config({
		:test1 => "hello",
		:test2 => "world!"
	})


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


