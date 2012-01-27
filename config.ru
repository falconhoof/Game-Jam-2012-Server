require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"       => Falconhoof::Web,
  "/api/v1" => Falconhoof::API
})
