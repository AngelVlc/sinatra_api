require File.expand_path "../app/main.rb", __FILE__

run Rack::URLMap.new({
  "/" => Public,
  "/api" => Api,
})
