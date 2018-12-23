require 'yaml'

class ConfigReader
  class << self
    def read
        @config = HashWithIndifferentAccess.new(YAML.load_file('config/app.yml'))
    end

    def get(key)
        @config[Sinatra::Application.environment][key]
    end
  end    
end