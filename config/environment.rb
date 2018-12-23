require "rubygems"
require "bundler"
require "active_support/deprecation"
require "active_support/all"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
require "sinatra/config_file"

require "./app/services/auth.rb"
require "./app/services/jwt_auth.rb"

require "./app/api/v1/health.rb"
require "./app/api/v1/auth.rb"
require "./app/api/v1/secure.rb"

require "./config/reader.rb"

ConfigReader.read
