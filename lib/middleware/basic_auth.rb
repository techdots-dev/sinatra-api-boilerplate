module Middleware
  class BasicAuth
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)

      if req.path.start_with?("/api/")
        auth = Rack::Auth::Basic::Request.new(env)
        unless auth.provided? && auth.basic? &&
               auth.credentials == [ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"]]
          return [401, { "Content-Type" => "application/json", "WWW-Authenticate" => "Basic realm=\"Restricted\"" }, [{ error: "Unauthorized" }.to_json]]
        end
      end

      @app.call(env)
    end
  end
end
