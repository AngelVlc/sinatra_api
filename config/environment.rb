require "rubygems"
require "bundler"
require "active_support/deprecation"
require "active_support/all"
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
require "sinatra/config_file"

APP_ROOT = File.expand_path("..", __dir__)

Dir.glob(File.join(APP_ROOT, "app", "models", "*.rb")).each { |file| require file }
Dir.glob(File.join(APP_ROOT, "app", "services", "*.rb")).each { |file| require file }

require "./app/api/v1/base.rb"
require "./app/api/v1/secured_base.rb"

Dir.glob(File.join(APP_ROOT, "app", "api", "v1", "*.rb")).each do |file|
  require file unless file.ends_with?("base.rb") || file.ends_with?("secured_base.rb")
end

require "./config/reader.rb"

ConfigReader.read
