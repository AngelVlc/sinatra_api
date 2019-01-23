#!/usr/bin/env ruby
require "net/http"
require "uri"

base_url = ARGV[0]

# Health
puts "---------------"
puts "Health"
puts "---------------"

uri = URI.parse(base_url + "/health")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
puts "Response code: #{response.code}"
puts "Response body: #{response.body}"

exit(1) if response.code != "200"

exit(0)