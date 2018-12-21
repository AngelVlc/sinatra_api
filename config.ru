require "./config/environment"

run Rack::URLMap.new({
  "/" => Public,
  "/health" => Api::V1::Health,
  "/auth" => Api::V1::Auth,
  "/api" => RootApi,
})
