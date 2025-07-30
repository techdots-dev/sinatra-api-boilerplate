require_relative "../lib/middleware/basic_auth"

class Base < Sinatra::Base
  configure do
    set :show_exceptions, false
    set :logging, true
    use Rack::Protection
    use Rack::Accept
    use Middleware::BasicAuth
  end

  before do
    content_type :json
    halt 406 unless request.accept.any? { |a| a.to_s == "application/json" }
  end

  error Sequel::NoMatchingRow do
    halt 404, { error: "Record not found" }.to_json
  end

  error do
    e = env["sinatra.error"]
    halt 500, { error: e.message }.to_json
  end
end
