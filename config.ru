require_relative "./config/environment"

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end

map '/' do
  run HomeController
end

map '/health' do
  run HealthController
end

map '/api' do
  run UsersController
end
