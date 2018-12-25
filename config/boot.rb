ENV['RACK_ENV'] ||= 'development'

# Bundler
require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require "./config/environment.rb"
