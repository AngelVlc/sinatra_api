require "./config/environment"

run Rack::URLMap.new({
  "/health" => Api::V1::Health,
  "/auth" => Api::V1::Auth,
  "/secure" => Api::V1::Secure
})
