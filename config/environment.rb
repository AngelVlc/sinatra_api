require "rubygems"
require "bundler"
require "active_support/deprecation"
require "active_support/all"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require "./app/main.rb"
require "./app/api/v1/health.rb"
require "./app/api/v1/auth.rb"
