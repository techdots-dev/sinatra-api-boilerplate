require 'rack/attack'

Rack::Attack.throttle('req/ip', limit: 300, period: 300) do |req|
  req.ip
end
