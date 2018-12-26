require "rubygems"
require "bundler"
require "active_support/deprecation"
require "active_support/all"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
require "sinatra/config_file"

APP_ROOT = File.expand_path("..", __dir__)

Dir.glob(File.join(APP_ROOT, "app", "models", "*.rb")).each { |file| require file }
Dir.glob(File.join(APP_ROOT, "app", "services", "*.rb")).each { |file| require file }

Dir.glob(File.join(APP_ROOT, "app", "api", "v1", "*.rb")).each { |file| require file }

require "./config/reader.rb"

ConfigReader.read
