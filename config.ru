require_relative "./config/environment"
require_relative "./app/controllers/users_controller"
require_relative "./app/controllers/home_controller"

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end

map '/' do
  run HomeController
end

map '/api' do
  run UsersController
end
