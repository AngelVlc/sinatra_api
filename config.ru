require "./config/environment"
require "raven"
require 'rack/protection'
require 'logger'

run Rack::URLMap.new({
  "/health" => Api::V1::Health,
  "/auth" => Api::V1::Auth,
  "/secure" => Api::V1::Secure,
  "/profile" => Api::V1::Profile,
  "/admin/users" => Api::V1::Admin::Users
})

environments_with_sentry = ["staging", "production"]

if environments_with_sentry.include?(ENV["RACK_ENV"])
  Raven.configure do |config|
    config.dsn = ConfigReader.get(:sentry_dsn)
  end

  use Raven::Rack
end

use Rack::Protection, :except => [:session_hijacking, :remote_token]

logger = Logger.new(STDOUT)

configure do
	use Rack::CommonLogger, logger
end