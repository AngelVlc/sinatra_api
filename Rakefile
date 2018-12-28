require "sinatra/activerecord"
require "sinatra/activerecord/rake"
require "rake"

if ENV["RACK_ENV"] == "test"
  require 'coveralls/rake/task'

  Coveralls::RakeTask.new
end