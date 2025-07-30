# app.rb
require "sinatra"
require "sequel"
require "dotenv/load"
require "./models/user"

DB = Sequel.connect(ENV["DATABASE_URL"])

before do
  protected_routes = ["/api"]
  if protected_routes.any? { |r| request.path_info.start_with?(r) }
    protected!
  end
end

helpers do
  def protected!
    return if authorized?

    headers["WWW-Authenticate"] = 'Basic realm="Restricted Area"'
    halt 401, { error: "Not authorized" }.to_json
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? &&
      @auth.basic? &&
      @auth.credentials &&
      @auth.credentials == [ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"]]
  end
end

get "/" do
  "Sinatra API is running."
end

get "/api/users" do
  content_type :json
  User.all.to_a.to_json
end
