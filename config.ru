require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"       => Falconhoof::Web,
  "/api/"   => Falconhoof::API::V1
  "/api/v1" => Falconhoof::API::V1
})
