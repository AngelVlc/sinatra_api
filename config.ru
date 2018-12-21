require "./config/environment"

run Rack::URLMap.new({
  "/" => Public,
  "/health" => Api::V1::Health,
  "/api" => RootApi,
})
