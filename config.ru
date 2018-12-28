require "./config/environment"
require "raven"
require 'rack/protection'

run Rack::URLMap.new({
  "/health" => Api::V1::Health,
  "/auth" => Api::V1::Auth,
  "/secure" => Api::V1::Secure
})

if ENV["RACK_ENV"] == "production"
  Raven.configure do |config|
    config.dsn = ConfigReader.get(:sentry_dsn)
  end
  
  use Raven::Rack
end

use Rack::Protection