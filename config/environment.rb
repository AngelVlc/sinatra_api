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

require "./app/api/base.rb"
require "./app/api/secured_base.rb"

Dir.glob(File.join(APP_ROOT, "app", "api", "v1", "*.rb")).each do |file|
  require file
end

Dir.glob(File.join(APP_ROOT, "app", "api", "v1", "admin", "*.rb")).each do |file|
  require file
end

require "./config/reader.rb"

ConfigReader.read
